; Auto-generated. Do not edit!


(cl:in-package kanu_pkg-msg)


;//! \htmlinclude Markers.msg.html

(cl:defclass <Markers> (roslisp-msg-protocol:ros-message)
  ((marker_info
    :reader marker_info
    :initarg :marker_info
    :type (cl:vector kanu_pkg-msg:MarkerInfo)
   :initform (cl:make-array 0 :element-type 'kanu_pkg-msg:MarkerInfo :initial-element (cl:make-instance 'kanu_pkg-msg:MarkerInfo))))
)

(cl:defclass Markers (<Markers>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Markers>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Markers)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kanu_pkg-msg:<Markers> is deprecated: use kanu_pkg-msg:Markers instead.")))

(cl:ensure-generic-function 'marker_info-val :lambda-list '(m))
(cl:defmethod marker_info-val ((m <Markers>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kanu_pkg-msg:marker_info-val is deprecated.  Use kanu_pkg-msg:marker_info instead.")
  (marker_info m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Markers>) ostream)
  "Serializes a message object of type '<Markers>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'marker_info))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'marker_info))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Markers>) istream)
  "Deserializes a message object of type '<Markers>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'marker_info) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'marker_info)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'kanu_pkg-msg:MarkerInfo))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Markers>)))
  "Returns string type for a message object of type '<Markers>"
  "kanu_pkg/Markers")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Markers)))
  "Returns string type for a message object of type 'Markers"
  "kanu_pkg/Markers")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Markers>)))
  "Returns md5sum for a message object of type '<Markers>"
  "233e0e9eb1ef4e1d8dc45028904252ed")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Markers)))
  "Returns md5sum for a message object of type 'Markers"
  "233e0e9eb1ef4e1d8dc45028904252ed")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Markers>)))
  "Returns full string definition for message of type '<Markers>"
  (cl:format cl:nil "MarkerInfo[] marker_info~%================================================================================~%MSG: kanu_pkg/MarkerInfo~%uint32 id~%float32[] rvec~%float32[] tvec~%float32 center_x~%float32 center_y~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Markers)))
  "Returns full string definition for message of type 'Markers"
  (cl:format cl:nil "MarkerInfo[] marker_info~%================================================================================~%MSG: kanu_pkg/MarkerInfo~%uint32 id~%float32[] rvec~%float32[] tvec~%float32 center_x~%float32 center_y~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Markers>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'marker_info) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Markers>))
  "Converts a ROS message object to a list"
  (cl:list 'Markers
    (cl:cons ':marker_info (marker_info msg))
))
