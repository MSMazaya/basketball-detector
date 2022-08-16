
import imutils
from imutils.video import VideoStream
from collections import deque
from imutils.video.count_frames import cv2
import numpy as np
import time


class Detector:
    def __init__(self, lowerColor, upperColor, bufferThickness):
        self.lowerColor = lowerColor
        self.upperColor = upperColor
        self.bufferThickness = bufferThickness
        self.pts = deque(maxlen=bufferThickness)

    def startCapture(self):
        self.vs = VideoStream(src=0).start()
        time.sleep(2)

    def getBallPosition(self):
        frame = self.vs.read()
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
        frame = self.vs.read()
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

    def destroy(self):
        self.vs.stop()
        cv2.destroyAllWindows()
