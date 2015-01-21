ros_xdotool
===============

* install
  * apt-get install xdotool

* usage
  * click event request      -> /ros_xdotool/click/button
  * mouse move event request -> /ros_xdotool/mouse_move/vector

```

> rostopic info /ros_xdotool/click/button
Type: std_msgs/Int32

Publishers: None

Subscribers:
 * /rostopic_29407_1417548366138 (http://192.168.96.214:44586/)


> rostopic info /ros_xdotool/command/string
Type: std_msgs/String

Publishers: None

Subscribers:
 * /rostopic_28973_1417548360660 (http://192.168.96.214:44641/)


> rostopic info /ros_xdotool/mouse_move/vector
Type: std_msgs/Float32MultiArray

Publishers: None

Subscribers:
 * /rostopic_29775_1417548372138 (http://192.168.96.214:41885/)

```
