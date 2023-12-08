#!/usr/bin/env python3

import rospy
import cv2
from cv2 import aruco
import numpy as np
import pyrealsense2 as rs
from kanu_pkg.msg import Markers
from kanu_pkg.msg import Marker_info

pipeline = rs.pipeline()
config = rs.config()
# color 가능 해상도 : 640x480, 424x240 ...
# depth 가능 해상도 : 640x480, 480,270 ...
config.enable_stream(rs.stream.color, 640, 480, rs.format.bgr8, 30)
pipeline.start(config)

aruco_dict = aruco.Dictionary_get(aruco.DICT_5X5_50)
parameters = aruco.DetectorParameters_create()

camera_matrix = np.array([[938.648156, 0.000000, 276.058054],
                    [0.000000, 925.197931, 267.135652],
                    [0.000000, 0.000000, 1.000000]])
distortion_coeff = np.array([0.776923, -2.483312, 0.029307, -0.038887, 0.0])

def main():
    rospy.init_node('estimate_marker_pose_node')

    pub_marker_pose = rospy.Publisher('marker_pose', Markers, queue_size=1)
    msg = Markers()

    rate = rospy.Rate(10)

    try:
        while not rospy.is_shutdown():
            frames = pipeline.wait_for_frames()
            c_frame = frames.get_color_frame()

            if not c_frame:
                continue

            c_img = np.asanyarray(c_frame.get_data())

            # 마커 검출
            corners, ids, _ = aruco.detectMarkers(c_img, aruco_dict, parameters=parameters)

            if ids is not None:
                # 검출된 마커가 있을 경우
                msg.marker = []  # 메시지의 리스트 초기화
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
                    pose_x = tvec[0][0][0]
                    pose_y = tvec[0][0][1]
                    pose_z = tvec[0][0][2]
                    theta = euler_angles

                    # 마커 정보를 단일 객체로 저장
                    marker = Marker_info()
                    marker.id = id
                    marker.x = pose_x
                    marker.y = pose_y
                    marker.z = pose_z
                    marker.theta = theta

                    msg.marker.append(marker)  # 메시지의 리스트에 추가

                    # 마커의 x, y 포즈 값 출력
                    rospy.loginfo("마커 ID: %s", id)
                    rospy.loginfo("마커의 x 포즈: %s", pose_x)
                    rospy.loginfo("마커의 y 포즈: %s", pose_y)
                    rospy.loginfo("마커의 거리(z): %s", pose_z)
                    rospy.loginfo("마커의 각도: %s", theta)
                    rospy.loginfo("")

            pub_marker_pose.publish(msg)

            rate.sleep()
    
    except rospy.ROSInterruptException:
        pass

    pipeline.stop()
    cv2.destroyAllWindows()

if __name__ == '__main__':
    main()