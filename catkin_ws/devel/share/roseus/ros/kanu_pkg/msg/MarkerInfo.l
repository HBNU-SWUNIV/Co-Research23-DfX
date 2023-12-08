;; Auto-generated. Do not edit!


(when (boundp 'kanu_pkg::MarkerInfo)
  (if (not (find-package "KANU_PKG"))
    (make-package "KANU_PKG"))
  (shadow 'MarkerInfo (find-package "KANU_PKG")))
(unless (find-package "KANU_PKG::MARKERINFO")
  (make-package "KANU_PKG::MARKERINFO"))

(in-package "ROS")
;;//! \htmlinclude MarkerInfo.msg.html


(defclass kanu_pkg::MarkerInfo
  :super ros::object
  :slots (_id _rvec _tvec _center_x _center_y ))

(defmethod kanu_pkg::MarkerInfo
  (:init
   (&key
    ((:id __id) 0)
    ((:rvec __rvec) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:tvec __tvec) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:center_x __center_x) 0.0)
    ((:center_y __center_y) 0.0)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _rvec __rvec)
   (setq _tvec __tvec)
   (setq _center_x (float __center_x))
   (setq _center_y (float __center_y))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:rvec
   (&optional __rvec)
   (if __rvec (setq _rvec __rvec)) _rvec)
  (:tvec
   (&optional __tvec)
   (if __tvec (setq _tvec __tvec)) _tvec)
  (:center_x
   (&optional __center_x)
   (if __center_x (setq _center_x __center_x)) _center_x)
  (:center_y
   (&optional __center_y)
   (if __center_y (setq _center_y __center_y)) _center_y)
  (:serialization-length
   ()
   (+
    ;; uint32 _id
    4
    ;; float32[] _rvec
    (* 4    (length _rvec)) 4
    ;; float32[] _tvec
    (* 4    (length _tvec)) 4
    ;; float32 _center_x
    4
    ;; float32 _center_y
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _id
       (write-long _id s)
     ;; float32[] _rvec
     (write-long (length _rvec) s)
     (dotimes (i (length _rvec))
       (sys::poke (elt _rvec i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _tvec
     (write-long (length _tvec) s)
     (dotimes (i (length _tvec))
       (sys::poke (elt _tvec i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _center_x
       (sys::poke _center_x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _center_y
       (sys::poke _center_y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32[] _rvec
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _rvec (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _rvec i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _tvec
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _tvec (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _tvec i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _center_x
     (setq _center_x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _center_y
     (setq _center_y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get kanu_pkg::MarkerInfo :md5sum-) "7c2d06f36b920e46bab4c11ad2f5b374")
(setf (get kanu_pkg::MarkerInfo :datatype-) "kanu_pkg/MarkerInfo")
(setf (get kanu_pkg::MarkerInfo :definition-)
      "uint32 id
float32[] rvec
float32[] tvec
float32 center_x
float32 center_y
")



(provide :kanu_pkg/MarkerInfo "7c2d06f36b920e46bab4c11ad2f5b374")


