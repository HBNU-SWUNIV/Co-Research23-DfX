#!/usr/bin/env python

import rospy
import cv2
from cv2 import aruco
import numpy as np
import pyrealsense2 as rs
from geometry_msgs.msg import Twist
import math

c_width = 640
c_height = 480
d_width = 640
d_height = 480
# color 가능 해상도 : 640x480, 424x240 ...
# depth 가능 해상도 : 640x480, 480,270 ...

pipeline = rs.pipeline()
config = rs.config()

config.enable_stream(rs.stream.color, c_width, c_height, rs.format.bgr8, 15)
config.enable_stream(rs.stream.depth, d_width, d_height, rs.format.z16, 15)
pipeline.start(config)

try:
    aruco_dict = aruco.Dictionary_get(aruco.DICT_4X4_50)
    parameters = aruco.DetectorParameters_create()
except AttributeError:
    aruco_dict = aruco.getPredefinedDictionary(aruco.DICT_4X4_50)
    parameters = aruco.DetectorParameters()

camera_matrix = np.array([
    [695.245733, 0.000000, 294.880846],
    [0.000000, 699.355221, 237.841017],
    [0.00000, 0.000000, 1.000000]])
distortion_coeff = np.array([0.229648, -0.580905, -0.003581, -0.001874, 0.000000])

rospy.init_node('go_straight_to_the_marker')
pub = rospy.Publisher('/cmd_vel', Twist, queue_size=1)

def forward_move(value):
    twist = Twist()
    twist.linear.x = value
    twist.linear.y = 0
    twist.linear.z = 0
    twist.angular.x = 0
    twist.angular.y = 0
    twist.angular.z = 0
    pub.publish(twist)

def rotation_move(value):
    twist = Twist()
    twist.linear.x = 0
    twist.linear.y = 0
    twist.linear.z = 0
    twist.angular.x = 0
    twist.angular.y = 0
    twist.angular.z = value
    pub.publish(twist)

def turn(value):
    twist = Twist()
    twist.linear.x = 0.1
    twist.linear.y = 0
    twist.linear.z = 0
    twist.angular.x = 0
    twist.angular.y = 0
    twist.angular.z = value
    pub.publish(twist)

def stop():
    twist = Twist()
    twist.linear.x = 0
    twist.linear.y = 0
    twist.linear.z = 0
    twist.angular.x = 0
    twist.angular.y = 0
    twist.angular.z = 0
    pub.publish(twist)

def centerOfMarker(corners):
    sumX = 0.
    sumY = 0.
    for i in range(4):
        sumX = sumX + corners[0][0][i][0]
        sumY = sumY + corners[0][0][i][1]

    return sumX/4, sumY/4 

def main():
    rate = rospy.Rate(1)

    try:
        while not rospy.is_shutdown():
            frames = pipeline.wait_for_frames()
            c_frame = frames.get_color_frame()
            d_frame = frames.get_depth_frame()

            if not c_frame or not d_frame:
                continue
            
            rospy.loginfo_once("I got frame.")

            c_img = np.asanyarray(c_frame.get_data())

            # 마커 검출
            corners, ids, _ = aruco.detectMarkers(c_img, aruco_dict, parameters=parameters)

            if ids is not None:
                # 검출된 마커가 있을 경우
                for i in range(len(ids)):
                    # 마커의 위치와 자세 추출
                    rvec, tvec, _ = aruco.estimatePoseSingleMarkers(corners[i], 0.05, camera_matrix, distortion_coeff)

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

                    marker_px = centerOfMarker(corners)
                    dist2marker = round(d_frame.get_distance(int(marker_px[0]), int(marker_px[1])) * 100, 3)

                    # 카메라의 중심을 (0,0)으로 두고 -10 ~ 10의 값으로 스케일링함.
                    # 카메라에서 가져온 프레임의 우하단 방향이 양(+)의 값
                    x = round((marker_px[0] - (c_width/2)) / c_width / 4 , 3) * 100
                    y = round((marker_px[1] - (c_height/2)) / c_height / 4 , 3) * 100

                    # 마커의 x, y 포즈 값 출력
                    rospy.loginfo("마커 ID: %s", id)
                    rospy.loginfo("마커의 x: %s", x)
                    rospy.loginfo("마커의 y: %s", y)
                    rospy.loginfo("마커의 거리: %s (cm)", dist2marker)
                    rospy.loginfo("마커의 각도: %s (degree)", theta)
                    rospy.loginfo("-----------------------------------")

                    # 방향을 바꿔야 하면
                    if abs(x) >= 0.8:
                        # 양수 일때
                        if x > 0:
                            rospy.loginfo("turn right")
                            turn(0.2)
                        else:
                            rospy.loginfo("turn left")
                            turn(-0.2)
                    else:
                        forward_move(0.3)

                    
                    #if pose_z <= 1:

            else:
                rotation_move(0.5)


            # 프레임에 마커 그리기
            frame = aruco.drawDetectedMarkers(c_img, corners, ids)

            # 결과 프레임 출력
            cv2.namedWindow('Frame')
            cv2.imshow('Frame', frame)
            cv2.waitKey(1)

            rate.sleep()
    
    except rospy.ROSInterruptException:
        pass

    pipeline.stop()
    cv2.destroyAllWindows()


if __name__ == '__main__':
    main()