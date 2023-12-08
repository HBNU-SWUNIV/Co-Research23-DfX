
(cl:in-package :asdf)

(defsystem "kanu_pkg-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "MarkerInfo" :depends-on ("_package_MarkerInfo"))
    (:file "_package_MarkerInfo" :depends-on ("_package"))
    (:file "Markers" :depends-on ("_package_Markers"))
    (:file "_package_Markers" :depends-on ("_package"))
  ))