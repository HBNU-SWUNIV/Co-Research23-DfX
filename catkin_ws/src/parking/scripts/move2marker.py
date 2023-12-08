#!/usr/bin/env python

import rospy
import cv2
from cv2 import aruco
import numpy as np
import pyrealsense2 as rs
from geometry_msgs.msg import Twist
import math
import threading


class kanu:
    def __init__(self):
        self.c_width = 424
        self.c_height = 240
        self.d_width = 480
        self.d_height = 270
        # color 가능 해상도 : 640x480, 424x240 ...
        # depth 가능 해상도 : 640x480, 480,270 ...

        # -0.16 ~ 0.16 직선운동
        # -1.0 ~ 1.0 회전운동

        self.pipeline = rs.pipeline()
        self.config = rs.config()

        self.config.enable_stream(rs.stream.color, self.c_width, self.c_height, rs.format.bgr8, 30)
        self.config.enable_stream(rs.stream.depth, self.d_width, self.d_height, rs.format.z16, 30)
        self.pipeline.start(self.config)

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

        rospy.init_node('go_straight_to_the_marker')
        self.pub = rospy.Publisher('/cmd_vel', Twist, queue_size=1)

        self.cam_rate = rospy.Rate(50)
        self.move_rate = rospy.Rate(3)
        self.is_find_marker = False
        self.time_to_find_marker = False
        self.marker_search_duration = rospy.Duration(3.0)

        self.lock = threading.Lock()
        self.thread = threading.Thread(target=self.move_robot)
        self.thread.daemon = True
        self.thread.start()


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

    def centerOfMarker(self, corners):
        sumX = 0.
        sumY = 0.
        for i in range(4):
            sumX = sumX + corners[0][0][i][0]
            sumY = sumY + corners[0][0][i][1]

        return sumX/4, sumY/4 

    def main(self):
    
        try:
            while not rospy.is_shutdown():
                
                frames = self.pipeline.wait_for_frames()
                c_frame = frames.get_color_frame()
                d_frame = frames.get_depth_frame()

                if not c_frame or not d_frame:
                    continue
                
                rospy.loginfo_once("I got frame.")

                c_img = np.asanyarray(c_frame.get_data())

                # 마커 검출
                corners, ids, _ = aruco.detectMarkers(c_img, self.aruco_dict, parameters=self.parameters)

                if ids is not None:
                    self.start_time = rospy.Time.now()
                    # 검출된 마커가 있을 경우
                    for i in range(len(ids)):
                        self.is_find_marker = True
                        # 마커의 위치와 자세 추출
                        rvec, tvec, _ = aruco.estimatePoseSingleMarkers(corners[i], 0.05, self.camera_matrix, self.distortion_coeff)

                        # rvec 회전벡터를 회전행렬로 변환
                        rotation_mtx, _ = cv2.Rodrigues(rvec)

                        # 회전 행렬로부터 각도 추출
                        theta_y = np.arctan2(rotation_mtx[0, 2], rotation_mtx[2, 2])

                        # 라디안을 degree로 변환
                        euler_angles = np.degrees(theta_y)

                        id = ids[i][0]

                        if euler_angles > 0:
                            theta = 180 - euler_angles
                        else:
                            theta = -(180 + euler_angles)

                        theta = round(theta, 3)

                        marker_px = self.centerOfMarker(corners)
                        self.dist2marker = round(d_frame.get_distance(int(marker_px[0]), int(marker_px[1])) * 100, 3)

                        # 카메라의 중심을 (0,0)으로 두고 -5 ~ 5의 값으로 스케일링함.
                        # 카메라에서 가져온 프레임의 우하단 방향이 양(+)의 값
                        self.x = round((marker_px[0] - (self.c_width/2)) / self.c_width / 4 , 3) * 100
                        self.y = round((marker_px[1] - (self.c_height/2)) / self.c_height / 4 , 3) * 100

                        # 마커의 x, y 포즈 값 출력
                        rospy.loginfo("마커 ID: %s", id)
                        rospy.loginfo("마커의 x: %s", self.x)
                        rospy.loginfo("마커의 y: %s", self.y)
                        rospy.loginfo("마커의 거리: %s (cm)", self.dist2marker)
                        rospy.loginfo("마커의 각도: %s (degree)", theta)
                        rospy.loginfo("-----------------------------------")

                elif self.time_to_find_marker == True:
                    self.time_to_find_marker = False
                    self.is_find_marker = False

                # 좀 전에 마커를 찾았지만 인식을 못하는 경우에 대비해서 일정시간동안 마커를 다시 인식하도록 기다려줌 
                elif self.is_find_marker == True:
                    #self.stop()
                    if rospy.Time.now() - self.start_time >= self.marker_search_duration:
                        self.time_to_find_marker = True
                    
                # 프레임에 마커 그리기
                frame = aruco.drawDetectedMarkers(c_img, corners, ids)

                # 결과 프레임 출력
                cv2.namedWindow('Frame')
                cv2.imshow('Frame', frame)
                cv2.waitKey(1)

                self.cam_rate.sleep()
        
        except rospy.ROSInterruptException:
            pass

        self.pipeline.stop()
        cv2.destroyAllWindows()

        

    def move_robot(self):
        while not rospy.is_shutdown():
            if self.is_find_marker == False:
                self.rotation_move(0.4)

            else:
                if self.dist2marker <= 25:
                   self.stop()
                   


                if abs(self.x) >= 0.8:
                    # 양수 일때
                    if self.x > 0:
                        #rospy.loginfo("turn right")
                        self.turn(-0.3)
                    else:
                        #rospy.loginfo("turn left")
                        self.turn(0.3)
                else:
                    self.forward_move(0.08)

            self.move_rate.sleep()


if __name__ == '__main__':
    k = kanu()
    k.main()