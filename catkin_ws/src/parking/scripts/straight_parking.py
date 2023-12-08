#!/usr/bin/env python

from nav_msgs.msg import Odometry
import rospy
import cv2
from cv2 import aruco
import numpy as np
import pyrealsense2 as rs
from geometry_msgs.msg import Twist
import threading
import math   
from std_msgs.msg import Float64

class RGBDCamera:
    def __init__(self):
        self.c_width = 640
        self.c_height = 480
        self.d_width = 640
        self.d_height = 480

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

        self.pipeline = rs.pipeline()
        config = rs.config()
        config.enable_stream(rs.stream.depth, self.d_width, self.d_height, rs.format.z16, 30)
        config.enable_stream(rs.stream.color, self.c_width, self.c_height, rs.format.bgr8, 30)
        self.pipeline.start(config)

        self.distance = float('inf')
        self.c_frame = None
        self.lock = threading.Lock()

        self.thread_frame_process = threading.Thread(target=self.frame_process)

        self.thread_frame_process.daemon = True
        self.thread_frame_process.start()

        self.frame_switch = True
        self.corners = None
        self.ids = None
        self.is_marker_find = False

        self.marker_x = None
        self.marker_y = None

    def frame_process(self):
        frame = None
        #cv2.namedWindow('Frame')
        try:
            while True:
                frames = self.pipeline.wait_for_frames()

                if self.frame_switch:
                    frame = frames.get_color_frame()
                else:
                    frame = frames.get_depth_frame()
    
                if not frame:
                    continue
                
                rospy.loginfo_once("I got frame.")

                if self.frame_switch:
                    frame = np.asanyarray(frame.get_data())
                    self.detect_marker(frame)
                else:
                    self.calc_distance(frame)
                    frame = np.asanyarray(frame.get_data())
                    frame = cv2.applyColorMap(cv2.convertScaleAbs(frame, alpha=0.03), cv2.COLORMAP_JET)

                #cv2.imshow('Frame', frame)
                cv2.waitKey(1)

        except rospy.ROSInterruptException:
            self.pipeline.stop()

    def detect_marker(self, frame):
        corners, ids, _ = aruco.detectMarkers(frame, self.aruco_dict, parameters=self.parameters)
        self.corners = corners
        self.ids = ids
        
        if ids is not None:
            rospy.loginfo("marker is detected.")
            self.is_marker_find = True
            for i in range(len(ids)):
                rvec, tvec, _ = aruco.estimatePoseSingleMarkers(corners[i], 0.05, self.camera_matrix, self.distortion_coeff)
            

    def calc_distance(self, d_frame):
        try:
            marker_px = self.centerOfMarker(self.corners)

            self.marker_x = (marker_px[0] - (self.c_width/2)) / self.c_width / 2

            dist = d_frame.get_distance(int(marker_px[0]), int(marker_px[1]))

            with self.lock:
                self.distance = dist * 100

        except rospy.ROSInterruptException:
            self.pipeline.stop()

    def centerOfMarker(self, corners):
        if corners is None:
            return 0, 0

        sumX = 0.
        sumY = 0.
        for i in range(4):
            sumX = sumX + corners[0][0][i][0]
            sumY = sumY + corners[0][0][i][1]
        
        return sumX/4, sumY/4 

    def get_distance(self):
        with self.lock:
            return self.distance

class RobotController:
    # -0.16 ~ 0.16 직선운동 max
    # -1.0 ~ 1.0 회전운동 max
    def __init__(self):
        self.pub = rospy.Publisher('/cmd_vel', Twist, queue_size=10)
        
    def forward_move(self, value=0.06):
        twist = Twist()
        twist.linear.x = value
        twist.linear.y = 0
        twist.linear.z = 0
        twist.angular.x = 0
        twist.angular.y = 0
        twist.angular.z = 0
        self.pub.publish(twist)

    def rotation_move(self, value=0.5):
        twist = Twist()
        twist.linear.x = 0
        twist.linear.y = 0
        twist.linear.z = 0
        twist.angular.x = 0
        twist.angular.y = 0
        twist.angular.z = value
        self.pub.publish(twist)

    def turn_right(self, value=0.3):
        twist = Twist()
        twist.linear.x = 0.06
        twist.linear.y = 0
        twist.linear.z = 0
        twist.angular.x = 0
        twist.angular.y = 0
        twist.angular.z = value
        self.pub.publish(twist)

    def turn_left(self, value=-0.3):
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

class Parking:
    def __init__(self):
        self.sub_imu = rospy.Subscriber('/filtered_imu', Float64, self.cbImu, queue_size=1)

        self.current_z = 0
        self.tolerance = 5.0  # 오차범위 설정
        self.target_z = 0.0  # 목표 Z축 값 설정
        self.controller = RobotController()

    def approching_parking_area(self):
        pass

    def cbImu(self, data):
        self.current_z = data.data
        rospy.loginfo('imu : %s', data)


def main():
    rospy.init_node('go_straight_to_the_marker')
    
    parking = Parking()
    cam = RGBDCamera()
    controller = RobotController()

    rate = rospy.Rate(100)

    target = 0.1
    
    try:
        while not rospy.is_shutdown():  
            if cam.is_marker_find == True:
                cam.is_marker_find = False
                cam.frame_switch = False

                rospy.sleep(0.5)

                cam.frame_switch = True
                dist = cam.get_distance()

                rospy.loginfo('%s', dist)
                rospy.loginfo('%s', cam.marker_x)

                if dist != 0 and dist < 25:
                    controller.stop()
                    break
                else:
                    if target < cam.marker_x:
                        controller.turn_left()
                    elif (-1 * target) > cam.marker_x:
                        controller.turn_right()
                    else:
                        controller.forward_move()

            rate.sleep()

    except rospy.ROSInterruptException:
        pass

    finally:
        parking.controller.stop()
        cv2.destroyAllWindows()

if __name__ == '__main__':
    main()