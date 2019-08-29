# ProtoVR
A VR control app for Proto

Displays 2 camera streams side by side to make it look like real while phone is inside the VR headset. Gyroscopic inputs have
to be used to know whether the user is looking up or down. Left or right movements for camera would be same as turning left or
right which are done using the same controller used to control the bot.

This project uses deviceMotion Library from the coreMotion Library in xcode. Calculates attitude.roll for x and attitude.yaw for y for head movements

v1.0: Detects head pointing locations and follows it to move Proto. Displays streams as VR Streams on the mainController. Head up is forward, head down is reverse, head straight is stop and looking to your left to right is making the robot turn left or right

