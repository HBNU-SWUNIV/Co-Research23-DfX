; Auto-generated. Do not edit!


(cl:in-package kanu_pkg-msg)


;//! \htmlinclude MarkerInfo.msg.html

(cl:defclass <MarkerInfo> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (rvec
    :reader rvec
    :initarg :rvec
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (tvec
    :reader tvec
    :initarg :tvec
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (center_x
    :reader center_x
    :initarg :center_x
    :type cl:float
    :initform 0.0)
   (center_y
    :reader center_y
    :initarg :center_y
    :type cl:float
    :initform 0.0))
)

(cl:defclass MarkerInfo (<MarkerInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MarkerInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MarkerInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kanu_pkg-msg:<MarkerInfo> is deprecated: use kanu_pkg-msg:MarkerInfo instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <MarkerInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kanu_pkg-msg:id-val is deprecated.  Use kanu_pkg-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'rvec-val :lambda-list '(m))
(cl:defmethod rvec-val ((m <MarkerInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kanu_pkg-msg:rvec-val is deprecated.  Use kanu_pkg-msg:rvec instead.")
  (rvec m))

(cl:ensure-generic-function 'tvec-val :lambda-list '(m))
(cl:defmethod tvec-val ((m <MarkerInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kanu_pkg-msg:tvec-val is deprecated.  Use kanu_pkg-msg:tvec instead.")
  (tvec m))

(cl:ensure-generic-function 'center_x-val :lambda-list '(m))
(cl:defmethod center_x-val ((m <MarkerInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kanu_pkg-msg:center_x-val is deprecated.  Use kanu_pkg-msg:center_x instead.")
  (center_x m))

(cl:ensure-generic-function 'center_y-val :lambda-list '(m))
(cl:defmethod center_y-val ((m <MarkerInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kanu_pkg-msg:center_y-val is deprecated.  Use kanu_pkg-msg:center_y instead.")
  (center_y m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MarkerInfo>) ostream)
  "Serializes a message object of type '<MarkerInfo>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'rvec))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'rvec))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'tvec))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'tvec))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'center_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'center_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MarkerInfo>) istream)
  "Deserializes a message object of type '<MarkerInfo>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'rvec) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'rvec)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'tvec) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'tvec)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'center_x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'center_y) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MarkerInfo>)))
  "Returns string type for a message object of type '<MarkerInfo>"
  "kanu_pkg/MarkerInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MarkerInfo)))
  "Returns string type for a message object of type 'MarkerInfo"
  "kanu_pkg/MarkerInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MarkerInfo>)))
  "Returns md5sum for a message object of type '<MarkerInfo>"
  "7c2d06f36b920e46bab4c11ad2f5b374")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MarkerInfo)))
  "Returns md5sum for a message object of type 'MarkerInfo"
  "7c2d06f36b920e46bab4c11ad2f5b374")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MarkerInfo>)))
  "Returns full string definition for message of type '<MarkerInfo>"
  (cl:format cl:nil "uint32 id~%float32[] rvec~%float32[] tvec~%float32 center_x~%float32 center_y~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MarkerInfo)))
  "Returns full string definition for message of type 'MarkerInfo"
  (cl:format cl:nil "uint32 id~%float32[] rvec~%float32[] tvec~%float32 center_x~%float32 center_y~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MarkerInfo>))
  (cl:+ 0
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'rvec) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'tvec) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MarkerInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'MarkerInfo
    (cl:cons ':id (id msg))
    (cl:cons ':rvec (rvec msg))
    (cl:cons ':tvec (tvec msg))
    (cl:cons ':center_x (center_x msg))
    (cl:cons ':center_y (center_y msg))
))
