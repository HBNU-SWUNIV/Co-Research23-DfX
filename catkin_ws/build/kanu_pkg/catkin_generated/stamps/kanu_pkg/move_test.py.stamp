#!/usr/bin/env python3

import rospy
from geometry_msgs.msg import Twist
from kanu_movement import Move

def main():

    try:
        m = Move()

        rate = rospy.Rate(1)
        
        global cnt
        cnt = 0

        while not rospy.is_shutdown():

            rate.sleep()
        
        rospy.spin()

    except rospy.ROSInterruptException:  pass


if __name__ == "__main__":
    main()