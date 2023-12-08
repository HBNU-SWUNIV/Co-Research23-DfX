; Auto-generated. Do not edit!


(cl:in-package kanu_pkg-srv)


;//! \htmlinclude DistServiceMessage-request.msg.html

(cl:defclass <DistServiceMessage-request> (roslisp-msg-protocol:ros-message)
  ((requestCode
    :reader requestCode
    :initarg :requestCode
    :type cl:integer
    :initform 0))
)

(cl:defclass DistServiceMessage-request (<DistServiceMessage-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DistServiceMessage-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DistServiceMessage-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kanu_pkg-srv:<DistServiceMessage-request> is deprecated: use kanu_pkg-srv:DistServiceMessage-request instead.")))

(cl:ensure-generic-function 'requestCode-val :lambda-list '(m))
(cl:defmethod requestCode-val ((m <DistServiceMessage-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kanu_pkg-srv:requestCode-val is deprecated.  Use kanu_pkg-srv:requestCode instead.")
  (requestCode m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DistServiceMessage-request>) ostream)
  "Serializes a message object of type '<DistServiceMessage-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'requestCode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'requestCode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'requestCode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'requestCode)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DistServiceMessage-request>) istream)
  "Deserializes a message object of type '<DistServiceMessage-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'requestCode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'requestCode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'requestCode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'requestCode)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DistServiceMessage-request>)))
  "Returns string type for a service object of type '<DistServiceMessage-request>"
  "kanu_pkg/DistServiceMessageRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DistServiceMessage-request)))
  "Returns string type for a service object of type 'DistServiceMessage-request"
  "kanu_pkg/DistServiceMessageRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DistServiceMessage-request>)))
  "Returns md5sum for a message object of type '<DistServiceMessage-request>"
  "81921970ef6bbdc458ce6f038299ceae")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DistServiceMessage-request)))
  "Returns md5sum for a message object of type 'DistServiceMessage-request"
  "81921970ef6bbdc458ce6f038299ceae")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DistServiceMessage-request>)))
  "Returns full string definition for message of type '<DistServiceMessage-request>"
  (cl:format cl:nil "uint32 requestCode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DistServiceMessage-request)))
  "Returns full string definition for message of type 'DistServiceMessage-request"
  (cl:format cl:nil "uint32 requestCode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DistServiceMessage-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DistServiceMessage-request>))
  "Converts a ROS message object to a list"
  (cl:list 'DistServiceMessage-request
    (cl:cons ':requestCode (requestCode msg))
))
;//! \htmlinclude DistServiceMessage-response.msg.html

(cl:defclass <DistServiceMessage-response> (roslisp-msg-protocol:ros-message)
  ((dist
    :reader dist
    :initarg :dist
    :type cl:float
    :initform 0.0))
)

(cl:defclass DistServiceMessage-response (<DistServiceMessage-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DistServiceMessage-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DistServiceMessage-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kanu_pkg-srv:<DistServiceMessage-response> is deprecated: use kanu_pkg-srv:DistServiceMessage-response instead.")))

(cl:ensure-generic-function 'dist-val :lambda-list '(m))
(cl:defmethod dist-val ((m <DistServiceMessage-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kanu_pkg-srv:dist-val is deprecated.  Use kanu_pkg-srv:dist instead.")
  (dist m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DistServiceMessage-response>) ostream)
  "Serializes a message object of type '<DistServiceMessage-response>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dist))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DistServiceMessage-response>) istream)
  "Deserializes a message object of type '<DistServiceMessage-response>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dist) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DistServiceMessage-response>)))
  "Returns string type for a service object of type '<DistServiceMessage-response>"
  "kanu_pkg/DistServiceMessageResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DistServiceMessage-response)))
  "Returns string type for a service object of type 'DistServiceMessage-response"
  "kanu_pkg/DistServiceMessageResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DistServiceMessage-response>)))
  "Returns md5sum for a message object of type '<DistServiceMessage-response>"
  "81921970ef6bbdc458ce6f038299ceae")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DistServiceMessage-response)))
  "Returns md5sum for a message object of type 'DistServiceMessage-response"
  "81921970ef6bbdc458ce6f038299ceae")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DistServiceMessage-response>)))
  "Returns full string definition for message of type '<DistServiceMessage-response>"
  (cl:format cl:nil "float32 dist~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DistServiceMessage-response)))
  "Returns full string definition for message of type 'DistServiceMessage-response"
  (cl:format cl:nil "float32 dist~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DistServiceMessage-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DistServiceMessage-response>))
  "Converts a ROS message object to a list"
  (cl:list 'DistServiceMessage-response
    (cl:cons ':dist (dist msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'DistServiceMessage)))
  'DistServiceMessage-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'DistServiceMessage)))
  'DistServiceMessage-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DistServiceMessage)))
  "Returns string type for a service object of type '<DistServiceMessage>"
  "kanu_pkg/DistServiceMessage")