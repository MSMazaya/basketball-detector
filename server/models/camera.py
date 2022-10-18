import subprocess
import imutils
from imutils.video import VideoStream
from collections import deque
from imutils.video.count_frames import cv2
import numpy as np
import time

class Camera:
    def __init__(self, lowerColor, upperColor, bufferThickness):
        self.lowerColor = lowerColor
        self.upperColor = upperColor
        self.bufferThickness = bufferThickness
        self.pts = deque(maxlen=bufferThickness)
        self.startedRTMP = False

    def startCapture(self):
        self.vs = cv2.VideoCapture(0)
        self.startRTMP()
        time.sleep(2)

    def getBallPosition(self):
        ret, frame = self.vs.read()
        if not ret: 
            return
        frame = imutils.resize(frame, width=600)

        blurred = cv2.GaussianBlur(frame, (11, 11), 0)
        hsv = cv2.cvtColor(blurred, cv2.COLOR_BGR2HSV)

        mask = cv2.inRange(hsv, self.lowerColor, self.upperColor)
        mask = cv2.erode(mask, None, iterations=2)
        mask = cv2.dilate(mask, None, iterations=2)

        cnts = cv2.findContours(
            mask.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        cnts = imutils.grab_contours(cnts)
        center = None

        # only proceed if at least one contour was found
        if len(cnts) > 0:
            # find the largest contour in the mask, then use
            # it to compute the minimum enclosing circle and
            # centroid
            c = max(cnts, key=cv2.contourArea)
            ((x, y), radius) = cv2.minEnclosingCircle(c)
            M = cv2.moments(c)
            center = (int(M["m10"] / M["m00"]), int(M["m01"] / M["m00"]))
            # only proceed if the radius meets a minimum size
            if radius > 10:
                # draw the circle and centroid on the frame,
                # then update the list of tracked points
                cv2.circle(frame, (int(x), int(y)), int(radius),
                           (0, 255, 255), 2)
                cv2.circle(frame, center, 5, (0, 0, 255), -1)
# update the points queue

        return center

    def trackBall(self, center):
        ret, frame = self.vs.read()
        if not ret:
            return
        self.pts.appendleft(center)

        # loop over the set of tracked points
        for i in range(1, len(self.pts)):
            # if either of the tracked points are None, ignore
            # them
            if self.pts[i - 1] is None or self.pts[i] is None:
                continue
            # otherwise, compute the thickness of the line and
            # draw the connecting lines
            thickness = int(np.sqrt(self.bufferThickness / float(i + 1)) * 2.5)
            cv2.line(frame, self.pts[i - 1],
                     self.pts[i], (0, 0, 255), thickness)

        cv2.imshow("Frame", frame)
        self.publishRTMP(frame)

    def startRTMP(self):
        rtmp_url = "rtmp://127.0.0.1:1935/stream/pupils_trace"
        fps = int(self.vs.get(cv2.CAP_PROP_FPS))
        width = int(self.vs.get(cv2.CAP_PROP_FRAME_WIDTH))
        height = int(self.vs.get(cv2.CAP_PROP_FRAME_HEIGHT))

        command = ['ffmpeg',
                   '-y',
                   '-f', 'rawvideo',
                   '-vcodec', 'rawvideo',
                   '-pix_fmt', 'bgr24',
                   '-s', "{}x{}".format(width, height),
                   '-r', str(fps),
                   '-i', '-',
                   '-c:v', 'libx264',
                   '-pix_fmt', 'yuv420p',
                   '-preset', 'ultrafast',
                   '-f', 'flv',
                   rtmp_url ]

        self.p = subprocess.Popen(command, stdin=subprocess.PIPE)
        self.startedRTMP = True

    def publishRTMP(self,frame):
        if self.startedRTMP:
            self.p.stdin.write(frame.tobytes())

    def destroy(self):
        self.vs.destroy()
        cv2.destroyAllWindows()


"""
usage example

import cv2
from models.camera import Camera

def createCamera():
    bufferThickness = 30
    orangeLower = (10, 200, 20)
    orangeUpper = (15, 255, 255)
    return Camera(orangeLower, orangeUpper, bufferThickness)

camera = createCamera()

camera.startCapture()

while True:
    position = camera.getBallPosition()

    # Showing frame + give ball trailing line
    camera.trackBall(position)

    key = cv2.waitKey(1) & 0xFF

    if key == ord("q"):
        break

camera.destroy()
"""
