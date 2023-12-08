
(cl:in-package :asdf)

(defsystem "kanu_pkg-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "DistServiceMessage" :depends-on ("_package_DistServiceMessage"))
    (:file "_package_DistServiceMessage" :depends-on ("_package"))
  ))