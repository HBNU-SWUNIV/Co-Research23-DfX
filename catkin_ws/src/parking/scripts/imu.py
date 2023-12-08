#!/usr/bin/env python3

import rospy
from sensor_msgs.msg import Imu
from std_msgs.msg import Float64
import math

class IMUFilter:
	def __init__(self):
		# 측정 오차의 분산을 추정
		
		self.R = 0.01  # 이 값을 변경하면 필터의 동작에 영향
		self.Q = 0.1 # 프로세스 분산

		# 초기 상태
		self.xhat = 0.0  # 프로세스 분산
		self.P = 1.0  # 추정값 x에 대한 사후 오차 분산
		self.xhatminus = 0.0  # 추정값 x에 대한 사후 오차 분산 -> [추정값 x = z축]
		self.Pminus = 1.0  # 추정값 x에 대한 사전 오차 분산
		self.K = 0.1  # 이득 또는 블렌딩 요소

	def quaternion_to_euler_angle(self, msg):
		x = msg.x
		y = msg.y
		z = msg.z
		w = msg.w

		ysqr = y * y
		
		t0 = +2.0 * (w * x + y * z)
		t1 = +1.0 - 2.0 * (x * x + ysqr)
		X = math.degrees(math.atan2(t0, t1))
		
		t2 = +2.0 * (w * y - z * x)
		t2 = +1.0 if t2 > +1.0 else t2
		t2 = -1.0 if t2 < -1.0 else t2
		Y = math.degrees(math.asin(t2))
		
		t3 = +2.0 * (w * z + x * y)
		t4 = +1.0 - 2.0 * (ysqr + z * z)
		Z = math.degrees(math.atan2(t3, t4))
		# print(Z)
		return Z

	def callback(self, msg):
		Z = self.quaternion_to_euler_angle(msg.orientation)

		# 시간 업데이트
		self.xhatminus = self.xhat
		self.Pminus = self.P + self.Q

		# 측정 업데이트
		self.K = self.Pminus / (self.Pminus + self.R)
		self.xhat = self.xhatminus + self.K * (Z - self.xhatminus)
		self.P = (1 - self.K) * self.Pminus

		self.publish_xhat()

	def publish_xhat(self):
		pub = rospy.Publisher('filtered_imu', Float64, queue_size=10)
		pub.publish(self.xhat)

def main():
	rospy.init_node('get_imu_data')
	filter = IMUFilter()
	sub = rospy.Subscriber('imu', Imu, filter.callback)
	rospy.spin()

if __name__ == "__main__":
	main()
