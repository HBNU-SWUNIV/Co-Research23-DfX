;; Auto-generated. Do not edit!


(when (boundp 'kanu_pkg::Markers)
  (if (not (find-package "KANU_PKG"))
    (make-package "KANU_PKG"))
  (shadow 'Markers (find-package "KANU_PKG")))
(unless (find-package "KANU_PKG::MARKERS")
  (make-package "KANU_PKG::MARKERS"))

(in-package "ROS")
;;//! \htmlinclude Markers.msg.html


(defclass kanu_pkg::Markers
  :super ros::object
  :slots (_marker_info ))

(defmethod kanu_pkg::Markers
  (:init
   (&key
    ((:marker_info __marker_info) (let (r) (dotimes (i 0) (push (instance kanu_pkg::MarkerInfo :init) r)) r))
    )
   (send-super :init)
   (setq _marker_info __marker_info)
   self)
  (:marker_info
   (&rest __marker_info)
   (if (keywordp (car __marker_info))
       (send* _marker_info __marker_info)
     (progn
       (if __marker_info (setq _marker_info (car __marker_info)))
       _marker_info)))
  (:serialization-length
   ()
   (+
    ;; kanu_pkg/MarkerInfo[] _marker_info
    (apply #'+ (send-all _marker_info :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; kanu_pkg/MarkerInfo[] _marker_info
     (write-long (length _marker_info) s)
     (dolist (elem _marker_info)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; kanu_pkg/MarkerInfo[] _marker_info
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _marker_info (let (r) (dotimes (i n) (push (instance kanu_pkg::MarkerInfo :init) r)) r))
     (dolist (elem- _marker_info)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get kanu_pkg::Markers :md5sum-) "233e0e9eb1ef4e1d8dc45028904252ed")
(setf (get kanu_pkg::Markers :datatype-) "kanu_pkg/Markers")
(setf (get kanu_pkg::Markers :definition-)
      "MarkerInfo[] marker_info
================================================================================
MSG: kanu_pkg/MarkerInfo
uint32 id
float32[] rvec
float32[] tvec
float32 center_x
float32 center_y
")



(provide :kanu_pkg/Markers "233e0e9eb1ef4e1d8dc45028904252ed")


