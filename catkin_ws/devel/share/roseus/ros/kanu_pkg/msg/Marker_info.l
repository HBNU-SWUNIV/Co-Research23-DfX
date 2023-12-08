;; Auto-generated. Do not edit!


(when (boundp 'kanu_pkg::Marker_info)
  (if (not (find-package "KANU_PKG"))
    (make-package "KANU_PKG"))
  (shadow 'Marker_info (find-package "KANU_PKG")))
(unless (find-package "KANU_PKG::MARKER_INFO")
  (make-package "KANU_PKG::MARKER_INFO"))

(in-package "ROS")
;;//! \htmlinclude Marker_info.msg.html


(defclass kanu_pkg::Marker_info
  :super ros::object
  :slots (_id _x _y _z _theta ))

(defmethod kanu_pkg::Marker_info
  (:init
   (&key
    ((:id __id) 0)
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:z __z) 0.0)
    ((:theta __theta) 0.0)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _z (float __z))
   (setq _theta (float __theta))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:z
   (&optional __z)
   (if __z (setq _z __z)) _z)
  (:theta
   (&optional __theta)
   (if __theta (setq _theta __theta)) _theta)
  (:serialization-length
   ()
   (+
    ;; uint32 _id
    4
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _z
    4
    ;; float32 _theta
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _id
       (write-long _id s)
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _z
       (sys::poke _z (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _theta
       (sys::poke _theta (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _z
     (setq _z (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _theta
     (setq _theta (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get kanu_pkg::Marker_info :md5sum-) "ed6a03d5e49c6d2e9ec3bae04b81cddb")
(setf (get kanu_pkg::Marker_info :datatype-) "kanu_pkg/Marker_info")
(setf (get kanu_pkg::Marker_info :definition-)
      "uint32 id
float32 x
float32 y
float32 z
float32 theta
")



(provide :kanu_pkg/Marker_info "ed6a03d5e49c6d2e9ec3bae04b81cddb")


