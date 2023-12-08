;; Auto-generated. Do not edit!


(when (boundp 'kanu_pkg::DistServiceMessage)
  (if (not (find-package "KANU_PKG"))
    (make-package "KANU_PKG"))
  (shadow 'DistServiceMessage (find-package "KANU_PKG")))
(unless (find-package "KANU_PKG::DISTSERVICEMESSAGE")
  (make-package "KANU_PKG::DISTSERVICEMESSAGE"))
(unless (find-package "KANU_PKG::DISTSERVICEMESSAGEREQUEST")
  (make-package "KANU_PKG::DISTSERVICEMESSAGEREQUEST"))
(unless (find-package "KANU_PKG::DISTSERVICEMESSAGERESPONSE")
  (make-package "KANU_PKG::DISTSERVICEMESSAGERESPONSE"))

(in-package "ROS")





(defclass kanu_pkg::DistServiceMessageRequest
  :super ros::object
  :slots (_requestCode ))

(defmethod kanu_pkg::DistServiceMessageRequest
  (:init
   (&key
    ((:requestCode __requestCode) 0)
    )
   (send-super :init)
   (setq _requestCode (round __requestCode))
   self)
  (:requestCode
   (&optional __requestCode)
   (if __requestCode (setq _requestCode __requestCode)) _requestCode)
  (:serialization-length
   ()
   (+
    ;; uint32 _requestCode
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _requestCode
       (write-long _requestCode s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _requestCode
     (setq _requestCode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass kanu_pkg::DistServiceMessageResponse
  :super ros::object
  :slots (_dist ))

(defmethod kanu_pkg::DistServiceMessageResponse
  (:init
   (&key
    ((:dist __dist) 0.0)
    )
   (send-super :init)
   (setq _dist (float __dist))
   self)
  (:dist
   (&optional __dist)
   (if __dist (setq _dist __dist)) _dist)
  (:serialization-length
   ()
   (+
    ;; float32 _dist
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _dist
       (sys::poke _dist (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _dist
     (setq _dist (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass kanu_pkg::DistServiceMessage
  :super ros::object
  :slots ())

(setf (get kanu_pkg::DistServiceMessage :md5sum-) "81921970ef6bbdc458ce6f038299ceae")
(setf (get kanu_pkg::DistServiceMessage :datatype-) "kanu_pkg/DistServiceMessage")
(setf (get kanu_pkg::DistServiceMessage :request) kanu_pkg::DistServiceMessageRequest)
(setf (get kanu_pkg::DistServiceMessage :response) kanu_pkg::DistServiceMessageResponse)

(defmethod kanu_pkg::DistServiceMessageRequest
  (:response () (instance kanu_pkg::DistServiceMessageResponse :init)))

(setf (get kanu_pkg::DistServiceMessageRequest :md5sum-) "81921970ef6bbdc458ce6f038299ceae")
(setf (get kanu_pkg::DistServiceMessageRequest :datatype-) "kanu_pkg/DistServiceMessageRequest")
(setf (get kanu_pkg::DistServiceMessageRequest :definition-)
      "uint32 requestCode
---
float32 dist
")

(setf (get kanu_pkg::DistServiceMessageResponse :md5sum-) "81921970ef6bbdc458ce6f038299ceae")
(setf (get kanu_pkg::DistServiceMessageResponse :datatype-) "kanu_pkg/DistServiceMessageResponse")
(setf (get kanu_pkg::DistServiceMessageResponse :definition-)
      "uint32 requestCode
---
float32 dist
")



(provide :kanu_pkg/DistServiceMessage "81921970ef6bbdc458ce6f038299ceae")


