#! /usr/bin/env python3

import rospy
import numpy as np
from enum import Enum
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Twist
import math
import cv2
from kanu_pkg.msg import Markers, MarkerInfo
from kanu_pkg.srv import DistServiceMessage, DistServiceMessageRequest

# RGBDcamera 클래스 외에 마커를 탐색하는 클래스나 코드를 작성하기.

PARKING_MARKER_ID = 8

# Markers
#   MarkerInfo[] marker_info

# MarkerInfo
#   uint32 id
#   float32[] rvec
#   float32[] tvec
#   float32 dist

class AutoParking():
    def __init__(self):

        # -0.16 ~ 0.16 직선운동 max
        # -1.0 ~ 1.0 회전운동 max

        self.sub_odom_robot = rospy.Subscriber('/odom', Odometry, self.cbGetRobotOdom, queue_size = 1)
        self.sub_info_marker = rospy.Subscriber('/marker_pose', Markers, self.cbGetMarkerInfo, queue_size=1)

        self.pub_cmd_vel = rospy.Publisher('/cmd_vel', Twist, queue_size=1)

        self.ParkingSequence = Enum('ParkingSequence', 'searching_parking_lot moving_marker_forward moving_nearby_parking_lot parking stop finished')
        self.current_parking_sequence = self.ParkingSequence.searching_parking_lot.value

        self.robot_2d_pose_x = .0
        self.robot_2d_pose_y = .0
        self.robot_2d_theta = .0
        self.marker_2d_pose_x = .0
        self.marker_2d_pose_y = .0
        self.marker_2d_theta = .0
        self.onRight = True

        self.previous_robot_2d_theta = .0
        self.total_robot_2d_theta = .0

        self.is_sequence_finished = False

        self.is_odom_received = False
        self.is_marker_pose_received = False

        self.cnt_fail_find_marker = 0

        loop_rate = rospy.Rate(10)

        while not rospy.is_shutdown():
            if self.is_odom_received is True:
                self.fnParking()

            loop_rate.sleep()
        
        rospy.on_shutdown(self.fnShutDown)
    
    def sendRequestDist(self):
        # 요청한 서버가 동작 중인지 확인
        rospy.wait_for_service('updateDist')

        try:   
            service_client = rospy.ServiceProxy('updateDist', DistServiceMessage)
            request_object = DistServiceMessageRequest()
            request_object.requestCode = 0

            result = service_client(request_object)
        
        except rospy.ServiceException as e:
            result = None
            rospy.logerr(e)
        
        return result

    def cbGetRobotOdom(self, robot_odom_msg):
        if self.is_odom_received == False:
            self.is_odom_received = True
        
        pos_x, pos_y, theta = self.fnGet2DRobotPose(robot_odom_msg)

        self.robot_2d_pose_x = pos_x
        self.robot_2d_pose_y = pos_y
        self.robot_2d_theta = theta

        # 각도의 주기성을 처리하여 로봇의 각도를 지속적으로 처리
        if (self.robot_2d_theta - self.previous_robot_2d_theta) > 5.:
            d_theta = (self.robot_2d_theta - self.previous_robot_2d_theta) - 2 * math.pi
        elif (self.robot_2d_theta - self.previous_robot_2d_theta) < -5.:
            d_theta = (self.robot_2d_theta - self.previous_robot_2d_theta) + 2 * math.pi
        else:
            d_theta = (self.robot_2d_theta - self.previous_robot_2d_theta)

        self.total_robot_2d_theta = self.total_robot_2d_theta + d_theta
        self.previous_robot_2d_theta = self.robot_2d_theta

        self.robot_2d_theta = self.total_robot_2d_theta

    def cbGetMarkerInfo(self, marker_info_msg):
        for msg in marker_info_msg.marker_info:
            if msg.id == PARKING_MARKER_ID:
                # 마커의 위치를 업데이트해야 할 때 아래 플래그를 False로 바꾸기
                if self.is_marker_pose_received == False:
                    self.is_marker_pose_received = True

                    pos_x, pos_y, theta = self.fnGet2DMarkerPose(marker_info_msg)

                    self.marker_2d_pose_x = pos_x
                    self.marker_2d_pose_y = pos_y

                    if theta >= 0:
                        self.onRight = True
                    else:
                        self.onRight = False

                    # 0에 가까울수록 정면. 부호는 마커의 회전 방향. 마커를 바라볼때 카메라가 오른쪽이면 양수.
                    self.marker_2d_theta = theta

    def fnParking(self):
        if self.current_parking_sequence == self.ParkingSequence.searching_parking_lot.value:
            rospy.loginfo("Seq 1 : searching parking lot")
            self.is_sequence_finished = self.fnSeqSearchingGoal()
            
            # 현재 절차가 정상적으로 완료되면
            if self.is_sequence_finished == True:
                rospy.loginfo("Finished 1")
                self.current_parking_sequence = self.ParkingSequence.moving_marker_forward.value
                self.is_sequence_finished = False

        elif self.current_parking_sequence == self.ParkingSequence.moving_marker_forward.value:
            rospy.loginfo("Seq 2 : moving marker forward")
            self.is_sequence_finished = self.fnMovingMarkerForward()

            if self.is_sequence_finished == True:
                rospy.loginfo("Finished 2")
                self.current_parking_sequence = self.ParkingSequence.moving_nearby_parking_lot.value
                self.is_sequence_finished = False
        
        elif self.current_parking_sequence == self.ParkingSequence.moving_nearby_parking_lot.value:
            rospy.loginfo("Seq 3 : moving nearby parking lot")
            self.is_sequence_finished = self.fnMovingNearbyParkingLot()

            if self.is_sequence_finished == True:
                rospy.loginfo("Finished 3")
                self.current_parking_sequence = self.ParkingSequence.parking.value
                self.is_sequence_finished = False

        elif self.current_parking_sequence == self.ParkingSequence.parking.value:
            rospy.loginfo("Seq 4 : parking")
            self.is_sequence_finished = self.fnSeqParking()

            if self.is_sequence_finished == True:
                rospy.loginfo("Finished 4")
                self.current_parking_sequence = self.ParkingSequence.stop.value
                self.is_sequence_finished = False

        elif self.current_parking_sequence == self.ParkingSequence.stop.value:
            self.fnStop()
            rospy.loginfo("Finished 5")
            self.current_parking_sequence = self.ParkingSequence.finished.value
            rospy.on_shutdown(self.fnShutDown)

    # seq 1
    def fnSeqSearchingGoal(self):
        if self.is_marker_pose_received == True:
            self.fnStop()
            return True
        else:
            self.fnRotationMove()

    # seq 2
    def fnMovingMarkerForward(self):
        if self.is_marker_pose_received == True:
            rospy.loginfo('Seq 2 Start...')

            # 회전해서 프레임의 가운데와 마커의 가운데가 가깝도록(x값만) 자세조정. 아래 거리 정확도 때문
            rospy.loginfo('move marker center')
            self.fnMoveMarkerCenter()

            # 한번 더 제자리에서 마커 정보 업데이트
            # rospy.loginfo('update marker pose')
            # self.fnUpdateMarkerPose(3)

            rospy.loginfo('calc valiables')
            # 마커까지의 거리
            dist2marker = self.sendRequestDist()
            while dist2marker == None:
                self.fnStop()
                dist2marker = self.sendRequestDist()
            dist2marker = dist2marker.dist * 100
            # 마커 정면까지 이동거리(cm) = 마커까지의 거리 * sin(마커의 y축 각도)
            dist2marker_front = float(dist2marker) * math.sin(abs(self.marker_2d_theta))
            #rospy.loginfo('dist2marker_front : %s', dist2marker_front)
            # 목표 회전각 = 90도 - 마커의 y축 각도
            target_angle = math.pi/2 - self.marker_2d_theta

            rospy.loginfo('calc done')

            # 1. 회전
            rospy.loginfo('rotate')
            if self.onRight:
                self.fnTargetRotation(target_angle)
            else:
                self.fnTargetRotation(-target_angle)

            # 2. 마커 정면까지 이동거리만큼 이동
            rospy.loginfo('go straight')
            self.fnTargetStraight(dist2marker_front)

            # 3. 반대로 회전
            rospy.loginfo('rotate reverse')
            self.is_marker_pose_received = False
            rate = rospy.Rate(10)
            while not self.is_marker_pose_received:
                if self.onRight:
                    self.fnRotationMove(-0.3)
                else:
                    self.fnRotationMove(0.3)
                rate.sleep()

            # 4. 마커의 정면인지 확인
            rospy.loginfo('at the marker front?')

            self.fnUpdateMarkerPose(10)
            self.fnMoveMarkerCenter()
            
            if abs(self.marker_2d_theta) <= math.radians(30):
                return True
            else:
                return False

            # 마커를 인식할 때까지 회전 -> 마커와 정면인지 확인(함수로 작성) -> 정면이면 true 반환, 아니면 false 반환.

    # seq 3
    def fnMovingNearbyParkingLot(self):
        self.fnUpdateMarkerPose(10)
        self.fnTrackMarker()
        return True
        
    # seq 4
    def fnSeqParking(self):
        self.fnStop()
        return True

    def fnStop(self):
        twist = Twist()
        twist.linear.x = 0
        twist.linear.y = 0
        twist.linear.z = 0
        twist.angular.x = 0
        twist.angular.y = 0
        twist.angular.z = 0
        self.pub_cmd_vel.publish(twist)

    def fnMoveMarkerCenter(self):
        # 마커가 중앙에서 왼쪽에 있으면 양수 값으로 회전. 
        rate = rospy.Rate(1)
        target = 0.02
        while True:
            if target < self.marker_2d_pose_x:
                self.fnRotationMove(-0.2)
                #rospy.loginfo('turn right')
            elif (-1 * target) > self.marker_2d_pose_x:
                self.fnRotationMove(0.2)
                #rospy.loginfo('turn left')
            else:
                self.fnStop()
                break

            rate.sleep()

            # self.fnUpdateMarkerPose(3)
            

    # 마커 정보를 업데이트함. 마커 인식 카운트만큼 인식 후 평균을 내서 최종 값으로 반환.
    def fnUpdateMarkerPose(self, measur_cnt):
        # 마커 인식 플래그를 바꿔서 마커가 잡히는지 확인
        self.is_marker_pose_received = False

        while True:
            if self.is_marker_pose_received == True:
                self.fnStop()

                pos_x = []
                pos_y = []
                theta = []

                for i in range(measur_cnt):
                    self.is_marker_pose_received = False
                    rospy.sleep(0.2)
                    pos_x.append(self.marker_2d_pose_x)
                    pos_y.append(self.marker_2d_pose_y)
                    theta.append(self.marker_2d_theta)
                
                self.marker_2d_pose_x = sum(pos_x) / len(pos_x)
                self.marker_2d_pose_y = sum(pos_y) / len(pos_y)
                self.marker_2d_theta = sum(theta) / len(theta)

                rospy.loginfo('new x: %s', self.marker_2d_pose_x)
                rospy.loginfo('new y: %s', self.marker_2d_pose_y)
                rospy.loginfo('new theta: %s', self.marker_2d_theta)
                rospy.loginfo('-----------------------------------')

                break
            else:    
                self.fnRotationMove()


    def fnRotationMove(self, value=0.3):
        twist = Twist()
        twist.linear.x = 0
        twist.linear.y = 0
        twist.linear.z = 0
        twist.angular.x = 0
        twist.angular.y = 0
        twist.angular.z = value
        self.pub_cmd_vel.publish(twist)

    def fnTargetRotation(self, target_angle):
        current_angle = 0.
        if target_angle > 0:
            target_angular_velocity = 0.3
        else:
            target_angular_velocity = -0.3
            target_angle = abs(target_angle)

        start_time = rospy.Time.now().to_sec()
        twist = Twist()
        rate = rospy.Rate(10)

        while current_angle < target_angle:
            twist.angular.z = target_angular_velocity
            self.pub_cmd_vel.publish(twist)
            rate.sleep()

            current_time = rospy.Time.now().to_sec()
            elapsed_time = current_time - start_time

            if target_angular_velocity < 0:
                current_angle = -target_angular_velocity * elapsed_time
            else:
                current_angle = target_angular_velocity * elapsed_time
        
        self.fnStop()

    def fnGoStraight(self, value=0.06):
        twist = Twist()
        twist.linear.x = value
        twist.linear.y = 0
        twist.linear.z = 0
        twist.angular.x = 0
        twist.angular.y = 0
        twist.angular.z = 0
        self.pub_cmd_vel.publish(twist)

    def fnTargetStraight(self, target_dist):
        current_dist = 0.
        target_linear_velocity = 0.06
        start_time = rospy.Time.now().to_sec()
        twist = Twist()
        rate = rospy.Rate(20)

        while current_dist < target_dist:
            twist.linear.x = target_linear_velocity
            self.pub_cmd_vel.publish(twist)
            rate.sleep()

            current_time = rospy.Time.now().to_sec()
            elapsed_time = current_time - start_time
            current_dist = target_linear_velocity * 100 * elapsed_time
        
        self.fnStop()

    def fnTrackMarker(self):
        rate = rospy.Rate(10)
        target = 0.01
        linear_speed = 0.05
        angular_speed = 0.2

        dist2marker = self.sendRequestDist()
        dist2marker = dist2marker.dist * 100

        twist = Twist()

        while True:
            if dist2marker == 0:
                self.fnStop()
                self.fnUpdateMarkerPose(3)
                continue
            elif dist2marker > 20:
                if target < self.marker_2d_pose_x:
                    twist.linear.x = linear_speed
                    twist.angular.z = -angular_speed
                elif (-1 * target) > self.marker_2d_pose_x:
                    twist.linear.x = linear_speed
                    twist.angular.z = angular_speed
                else:
                    twist.linear.x = linear_speed
                    twist.angular.z = 0.
            else:
                break

            dist = self.sendRequestDist()
            while dist == None:
                self.fnStop()
                dist = self.sendRequestDist()
            dist2marker = dist.dist * 100
            rospy.loginfo("fnTrack; dist = %s", dist2marker)
            self.pub_cmd_vel.publish(twist)  
            rate.sleep()
            
        self.fnStop()

    def quaternion_to_euler(self, quaternion):
        x, y, z, w = quaternion
        t0 = +2.0 * (w * x + y * z)
        t1 = +1.0 - 2.0 * (x * x + y * y)
        roll_x = np.arctan2(t0, t1)

        t2 = +2.0 * (w * y - z * x)
        t2 = +1.0 if t2 > +1.0 else t2
        t2 = -1.0 if t2 < -1.0 else t2
        pitch_y = np.arcsin(t2)

        t3 = +2.0 * (w * z + x * y)
        t4 = +1.0 - 2.0 * (y * y + z * z)
        roll_z = np.arctan2(t3, t4)

        return roll_x, pitch_y, roll_z

    def fnGet2DRobotPose(self, robot_odom_msg):
        # /odom 토픽으로 부터 받은 로봇의 방향.
        quaternion = (robot_odom_msg.pose.pose.orientation.x, robot_odom_msg.pose.pose.orientation.y, robot_odom_msg.pose.pose.orientation.z, robot_odom_msg.pose.pose.orientation.w)
        # 각도를 quaternion에서 euler 값으로 변환
        theta = self.quaternion_to_euler(quaternion)[2]

        # 음의 각도를 양의 각도로 변환
        if theta < 0:
            theta = theta + np.pi * 2
        # 360도를 넘는 각도를 변환
        if theta > np.pi * 2:
            theta = theta - np.pi * 2

        # 로봇의 위치
        pos_x = robot_odom_msg.pose.pose.position.x
        pos_y = robot_odom_msg.pose.pose.position.y

        return pos_x, pos_y, theta
    
    def fnGet2DMarkerPose(self, marker_pose_msg):
        rvec = marker_pose_msg.marker_info[0].rvec
        tvec = marker_pose_msg.marker_info[0].tvec
        center_x = marker_pose_msg.marker_info[0].center_x
        center_y = marker_pose_msg.marker_info[0].center_y

        rotation_matrix, _ = cv2.Rodrigues(rvec)
        #rospy.loginfo(rotation_matrix)
        theta = np.arctan2(rotation_matrix[0, 2], rotation_matrix[2, 2])

        if theta > 0:
            theta = theta - math.pi
        else:
            theta = theta + math.pi

        return center_x, center_y, theta

    def fnShutDown(self):
        rospy.loginfo("Shutting down. cmd_vel will be 0")

        twist = Twist()
        twist.linear.x = 0
        twist.linear.y = 0
        twist.linear.z = 0
        twist.angular.x = 0
        twist.angular.y = 0
        twist.angular.z = 0
        self.pub_cmd_vel.publish(twist)

    def main(self):
        # 콜백함수를 노드가 종료되기 전까지 처리.
        rospy.spin()

if __name__ == '__main__':
    rospy.init_node('automatic_parking')

    node = AutoParking()
    node.main()


    # 마커 인식 -> 마커 인식 안됨 -> 3번 프레임 정도는 이전 마커 정보 활용 -> 계속 마커를 못 ㅣㄴ식하면 마커 재탐색