#!/usr/bin/env python

import rospy
import cv2
from cv2 import aruco
import numpy as np
import pyrealsense2 as rs
from geometry_msgs.msg import Twist
import math   
import threading

class RGBDCamera:
    def __init__(self):
        self.c_width = 424
        self.c_height = 240
        self.d_width = 640
        self.d_height = 480

        self.distance = float('inf')
        self.c_img = None
        self.lock = threading.Lock()

        self.thread_depth = threading.Thread(target=self.update_distance)
        self.thread_rgb = threading.Thread(target=self.update_rgb)

        self.thread_depth.daemon = True
        self.thread_depth.start()

        self.thread_rgb.daemon = True
        self.thread_rgb.start()

    def update_distance(self):
        pipeline = rs.pipeline()
        config = rs.config()
        config.enable_stream(rs.stream.depth, self.d_width, self.d_height, rs.format.z16, 30)
        pipeline.start(config)

        try:
            while True:
                frames = pipeline.wait_for_frames()     
                d_frame = frames.get_depth_frame()

                if not d_frame:
                    continue

                rospy.loginfo_once("I got depth frame.")
                d_img = np.asanyarray(d_frame.get_data())

                depth_scaled = d_frame.as_depth_frame().get_units()
                avg_distance = np.average(d_img) * depth_scaled

                with self.lock:
                    self.distance = avg_distance

        finally:
            pipeline.stop()

    def update_rgb(self):
        pipeline = rs.pipeline()
        config = rs.config()
        config.enable_stream(rs.stream.color, self.c_width, self.c_height, rs.format.bgr8, 30)
        pipeline.start(config)

        try:
            while True:
                frames = pipeline.wait_for_frames()
                c_frame = frames.get_color_frame()

                if not c_frame:
                    continue

                rospy.loginfo_once("I got color frame.")
                c_img = np.asanyarray(c_frame.get_data())

                with self.lock:
                    self.c_img = c_img

        finally:
            pipeline.stop()

    def get_distance(self):
        with self.lock:
            return self.distance

    def get_rgb(self):
        with self.lock:
            return self.c_img

class RobotController:
    def __init__(self):
        self.pub = rospy.Publisher('/cmd_vel', Twist, queue_size=1)
        
    def forward_move(self, value):
        twist = Twist()
        twist.linear.x = value
        twist.linear.y = 0
        twist.linear.z = 0
        twist.angular.x = 0
        twist.angular.y = 0
        twist.angular.z = 0
        self.pub.publish(twist)

    def rotation_move(self, value):
        twist = Twist()
        twist.linear.x = 0
        twist.linear.y = 0
        twist.linear.z = 0
        twist.angular.x = 0
        twist.angular.y = 0
        twist.angular.z = value
        self.pub.publish(twist)

    def turn(self, value):
        twist = Twist()
        twist.linear.x = 0.06
        twist.linear.y = 0
        twist.linear.z = 0
        twist.angular.x = 0
        twist.angular.y = 0
        twist.angular.z = value
        self.pub.publish(twist)

    def stop(self):
        twist = Twist()
        twist.linear.x = 0
        twist.linear.y = 0
        twist.linear.z = 0
        twist.angular.x = 0
        twist.angular.y = 0
        twist.angular.z = 0
        self.pub.publish(twist)

class Kanu:
    def __init__(self):
        
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
        self.marker_search_duration = rospy.Duration(3.0)

        
        self.is_find_marker = False
        self.time_to_find_marker = False
        self.start_time = None
        self.x = None
        self.y = None
        self.theta = None
        self.dist2marker = None

    def detect_marker(self, img):
        corners, ids, _ = aruco.detectMarkers(img, self.aruco_dict, parameters=self.parameters)
        return corners, ids

    def estimate_pose(self, corners):
        rvec, tvec, _ = aruco.estimatePoseSingleMarkers(corners[0], 0.05, self.camera_matrix, self.distortion_coeff)
        return rvec, tvec

    def compute_euler_angle(self, rvec):
        rotation_mtx, _ = cv2.Rodrigues(rvec)
        theta_y = np.arctan2(rotation_mtx[0, 2], rotation_mtx[2, 2])
        euler_angles = np.degrees(theta_y)
        return euler_angles

    def compute_center_of_marker(self, corners):
        sumX = 0.
        sumY = 0.
        for i in range(4):
            sumX = sumX + corners[0][0][i][0]
            sumY = sumY + corners[0][0][i][1]
        return sumX/4, sumY/4 

    def update_marker_states(self, img, cam):

        corners, ids = self.detect_marker(img)

        if ids is not None:
            self.start_time = rospy.Time.now()
            self.is_find_marker = True
            rvec, _ = self.estimate_pose(corners)
            euler_angles = self.compute_euler_angle(rvec)

            if euler_angles > 0:
                self.theta = 180 - euler_angles
            else:
                self.theta = -(180 + euler_angles)

            self.theta = round(self.theta, 3)
            marker_px = self.compute_center_of_marker(corners)
            self.dist2marker = round(cam.get_distance(int(marker_px[0]), int(marker_px[1])) * 100, 3)
            self.x = round((marker_px[0] - (cam.c_width/2)) / cam.c_width / 4 , 3) * 100
            self.y = round((marker_px[1] - (cam.c_height/2)) / cam.c_height / 4 , 3) * 100

            return True
        else:
            if self.is_find_marker and (rospy.Time.now() - self.start_time >= self.marker_search_duration):
                self.time_to_find_marker = True
            return False

def main():
    rospy.init_node('go_straight_to_the_marker')
    
    kanu = Kanu()
    cam = RGBDCamera()
    controller = RobotController()

    cam_rate = rospy.Rate(30)
    move_rate = rospy.Rate(5)

    try:
        while not rospy.is_shutdown():
            
            if not cam:
                continue

            if kanu.update_marker_states(cam.get_rgb(), cam):
                rospy.loginfo("마커 ID: %s", id)
                rospy.loginfo("마커의 x: %s", kanu.x)
                rospy.loginfo("마커의 y: %s", kanu.y)
                rospy.loginfo("마커의 거리: %s (cm)", kanu.dist2marker)
                rospy.loginfo("마커의 각도: %s (degree)", kanu.theta)
                rospy.loginfo("-----------------------------------")
                
            if not kanu.is_find_marker:
                controller.forward_move(0.4)
            else:
                if abs(kanu.x) >= 0.8:
                    if kanu.x > 0:
                        rospy.loginfo("turn right")
                        controller.turn(-0.3)
                    else:
                        rospy.loginfo("turn left")
                        controller.turn(0.3) 
                else:
                    controller.forward_move(0.08)

            move_rate.sleep()
        cam_rate.sleep()

    except rospy.ROSInterruptException:
        pass

    cv2.destroyAllWindows()

if __name__ == '__main__':
    main()