#!/usr/bin/env python3

import math
import sys
import rospy
from geometry_msgs.msg import Twist
from std_msgs.msg import Float64

rospy.init_node('move', anonymous=True)
move_pub = rospy.Publisher('/cmd_vel', Twist, queue_size=10)
rate = rospy.Rate(3)

class IMUManager:
    def __init__(self):
        self.current_z = 0.0
        self.subscriber = rospy.Subscriber('filtered_imu', Float64, self.imu_callback)
    
    def imu_callback(self, data):
        self.current_z = data.data

class bobocar:

    def forward_control(self, value):
        value = float(value)
        twist = Twist()
        twist.linear.x = value
        move_pub.publish(twist)
        # print("linear : ", twist.linear.x)
        return twist.linear.x

    def turn_control(self, value):
        value = float(value)
        twist = Twist()
        twist.angular.z = value
        move_pub.publish(twist)
        # print("angular : ", twist.angular.z)
        return twist.angular.z

    def angle_control(self, value):
        value = float(value)
        twist = Twist()
        twist.angular.z = value
        twist.linear.x = value * 0.4 ; twist.angular.z = value
        if twist.linear.x <= 0:
            twist.linear.x = abs(twist.linear.x)
        move_pub.publish(twist)

        # print("liner : ", twist.linear.x, end='\n')
        # print("angular : ", twist.angular.z, end='\n')

        return twist.linear.x, twist.angular.z

    def stop_control(self):
    
        twist = Twist()
        twist.linear.x = 0 ; twist.angular.z = 0
        move_pub.publish(twist)

        # print("liner : ", twist.linear.x, end='\n')
        # print("angular : ", twist.angular.z, end='\n')

        return twist.linear.x, twist.angular.z

def main():
    imu_manager = IMUManager()
    car = bobocar()

    tolerance = 5.0  # 오차범위 설정
    target_z = 0.0  # 목표 Z축 값 설정

    try:
        while not rospy.is_shutdown():
            error = target_z - imu_manager.current_z  # 오차 계산
            print("---------------------------------------------------------",end='\n')
            print("error : ", error, end='\n')
            print("target_z : ", target_z, end='\n')
            print("imu_manager.current_z : ", imu_manager.current_z, end='\n')

            if abs(error) < tolerance:  # 오차가 허용범위 내인 경우
                car.forward_control(0.1)  # 직진
                print("forword")
                print("---------------------------------------------------------",end='\n')
            elif error > 0:  # 오른쪽으로 치우친 경우
                car.angle_control(0.1)  # 왼쪽으로 회전
                print("left")
                print("---------------------------------------------------------",end='\n')
            else:  # 왼쪽으로 치우친 경우
                car.angle_control(-0.1)  # 오른쪽으로 회전
                print("rigth")
                print("---------------------------------------------------------",end='\n')

            rate.sleep()
    except:
        sys.exit()

if __name__ == "__main__":
    main()
