#!/usr/bin/env python3
#camera setting => distance , marker info(x,y,z)

import rospy
import numpy as np
import cv2
from cv2 import aruco
import pyrealsense2 as rs
import threading
from kanu_pkg.msg import Markers, MarkerInfo
from kanu_pkg.srv import DistServiceMessage, DistServiceMessageResponse

# Markers
#   MarkerInfo[] marker_info

# MarkerInfo
#   uint32 id
#   float32[] rvec
#   float32[] tvec
#   float32 dist

class RGBDCamera:
    def __init__(self):
        self.srv_update_dist = rospy.Service('updateDist', DistServiceMessage, self.cbUpdateDist)

        self.pub_marker_info = rospy.Publisher('/marker_pose', Markers, queue_size=1)

        self.c_width = 640
        self.c_height = 480
        self.d_width = 640
        self.d_height = 480

        self.pipeline = rs.pipeline()
        config = rs.config()
        config.enable_stream(rs.stream.depth, self.d_width, self.d_height, rs.format.z16, 30)
        config.enable_stream(rs.stream.color, self.c_width, self.c_height, rs.format.bgr8, 30)
        self.pipeline.start(config)

        try:
            self.aruco_dict = aruco.Dictionary_get(aruco.DICT_4X4_50)
            self.parameters = aruco.DetectorParameters_create()
        except AttributeError:
            self.aruco_dict = aruco.getPredefinedDictionary(aruco.DICT_4X4_50)
            self.parameters = aruco.DetectorParameters()

        self.camera_matrix = np.array([
            [695.245733, 0.000000, 294.880846],
            [0.000000, 699.355221, 237.841017],
            [0.00000, 0.000000, 1.000000]])
        self.distortion_coeff = np.array([0.229648, -0.580905, -0.003581, -0.001874, 0.000000])

        self.distance = None
        self.c_img = None
        self.rvec = None
        self.tvec = None

        self.corners = None

    def cbUpdateDist(self, data):
        
        response = DistServiceMessageResponse()

        if self.corners is not None:
            dist = 0
            for i in range(3):
                dist = dist + self.process_depth_frame()
            self.distance = dist / 3
            response.dist = self.distance
            self.distance = None
        else:
            response.dist = 0.
        
        return response
        
    def centerOfMarker(self, corners):
        sumX = 0.
        sumY = 0.
        if corners is None:
            return -1, -1
        for i in range(4):
            sumX = sumX + corners[0][0][i][0]
            sumY = sumY + corners[0][0][i][1]

        return sumX/4, sumY/4

    def process_depth_frame(self):
        #rate = rospy.Rate(10)
        frames = self.pipeline.wait_for_frames()     
        d_frame = frames.get_depth_frame()

        if d_frame is not None and self.corners is not None:
            rospy.loginfo_once("I got depth frame.")

            marker_px = self.centerOfMarker(self.corners)
            dist = d_frame.get_distance(int(marker_px[0]), int(marker_px[1]))

            self.corners = None
            #rate.sleep()
        
        else:
            dist = 0.
        
        return dist

    def process_color_frame(self):
        frames = self.pipeline.wait_for_frames()
        c_frame = frames.get_color_frame()

        if c_frame:
            rospy.loginfo_once("I got color frame.")

            c_img = np.asanyarray(c_frame.get_data())

            self.corners, ids, _ = aruco.detectMarkers(c_img, self.aruco_dict, parameters=self.parameters)

            if ids is not None:
                markers_msg = Markers()
                for i in range(len(ids)):
                    rvec, tvec, _ = aruco.estimatePoseSingleMarkers(self.corners[i], 0.05, self.camera_matrix, self.distortion_coeff)
                    marker_info = MarkerInfo()
                    marker_info.id = ids[i][0]
                    marker_info.rvec = rvec.flatten().tolist()
                    marker_info.tvec = tvec.flatten().tolist()

                    marker_center = self.centerOfMarker(self.corners)
                    marker_info.center_x = (marker_center[0] - (self.c_width/2)) / self.c_width / 2
                    marker_info.center_y = (marker_center[1] - (self.c_height/2)) / self.c_height / 2

                    markers_msg.marker_info.append(marker_info)

                self.pub_marker_info.publish(markers_msg)

            cv2.namedWindow('Frame')
            cv2.imshow('Frame', c_img)
            cv2.waitKey(1)

    def stop_pipeline(self):
        self.pipeline.stop()

    def main(self):
        try:
            while not rospy.is_shutdown():
                self.process_color_frame()

        finally:
            self.stop_pipeline()
        
if __name__ == '__main__':
    rospy.init_node('rgbd_cam')
    node = RGBDCamera()
    node.main()