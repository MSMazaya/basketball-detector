import numpy as np
import cv2

from collections import deque
from imutils.video import VideoStream

import argparse
import imutils
import time

# construct the argument parse and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-v", "--video",
	help="path to the (optional) video file")
ap.add_argument("-b", "--buffer", type=int, default=64,
	help="max buffer size")
args = vars(ap.parse_args())

color = (0, 255, 0)
thickness = 9

# list of tracked points
greenLower = (10, 150, 100)
greenUpper = (25, 255, 255)
# greenLower = (29, 86, 6)
# greenUpper = (64, 255, 255)
pts = deque(maxlen=args["buffer"])

cap = cv2.VideoCapture(0)

def draw_line(image, start_point, end_point, color, thickness):
    image = cv2.line(image, start_point, end_point, color, thickness)

def detectPosition(input_x, input_y):
    if (input_y < line_h_top[0][1] and input_x > line_v_left[1][0] and input_x < line_v_right[1][0]):
        return 3
    elif (input_x < line_v[0][0] and input_y < line_h[0][1]) and input_y > line_h_top[0][1]:
        return 4
    elif (input_x > line_v[1][0] and input_y < line_h[0][1]) and input_y > line_h_top[0][1]:
        return 2
    elif (input_x < line_v[0][0] and input_y > line_h[1][1]) :
        return 5
    elif (input_x > line_v[1][0] and input_y > line_h[1][1]) :
        return 1



# detected_position = 'kiri atas'

# input_x = float(input('Posisi x: '))
# input_y = float(input('Posisi y: '))

# while(cap.isOpened()):
while(True):
    ret, image = cap.read()
    
    
    #==========================================================
    image = imutils.resize(image, width=600)
    blurred = cv2.GaussianBlur(image, (11, 11), 0)
    hsv = cv2.cvtColor(blurred, cv2.COLOR_BGR2HSV)
    mask = cv2.inRange(hsv, greenLower, greenUpper)
    mask = cv2.erode(mask, None, iterations=2)
    mask = cv2.dilate(mask, None, iterations=2)
    

    cnts = cv2.findContours(mask.copy(), cv2.RETR_EXTERNAL,
        cv2.CHAIN_APPROX_SIMPLE)
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

        center_x, center_y = center
        detected_position = detectPosition(center_x, center_y)
        cv2.putText(image, detected_position, (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2, cv2.LINE_AA)
        
        # print(center)
        # only proceed if the radius meets a minimum size
        if radius > 10:
            # draw the circle and centroid on the image,
            # then update the list of tracked points
            cv2.circle(image, (int(x), int(y)), int(radius),
                (0, 255, 255), 2)
            cv2.circle(image, center, 5, (0, 0, 255), -1)
    # update the points queue
    pts.appendleft(center)
    for i in range(1, len(pts)):
        # if either of the tracked points are None, ignore
        # them
        if pts[i - 1] is None or pts[i] is None:
            continue
        # otherwise, compute the thickness of the line and
        # draw the connecting lines
        thickness = int(np.sqrt(args["buffer"] / float(i + 1)) * 2.5)
        cv2.line(image, pts[i - 1], pts[i], (0, 0, 255), thickness)

    #==========================================================
    
    
    line_v = [[image.shape[1]/2, image.shape[0]*1/2],[image.shape[1]/2, image.shape[0]]]
    line_v_left = [[image.shape[1]*2/5, image.shape[0]*1/3],[image.shape[1]*2/5, image.shape[0]*1/2]]
    line_v_right = [[image.shape[1]*3/5, image.shape[0]*1/3],[image.shape[1]*3/5, image.shape[0]*1/2]]
    line_h = [[image.shape[1]*1/10, image.shape[0]*3/4],[image.shape[1]*9/10, image.shape[0]*3/4]]
    line_h_top = [[image.shape[1]*2/5, image.shape[0]*1/2],[image.shape[1]*3/5, image.shape[0]*1/2]]
    
    draw_line(image, ( int(line_v[1][0]), int(line_v[1][1]) ), (int(line_v[0][0]), int(line_v[0][1])), color, thickness)
    draw_line(image, ( int(line_h[1][0]), int(line_h[1][1]) ), (int(line_h[0][0]), int(line_h[0][1])), color, thickness)
    draw_line(image, ( int(line_h_top[1][0]), int(line_h_top[1][1]) ), (int(line_h_top[0][0]), int(line_h_top[0][1])), color, thickness)
    draw_line(image, ( int(line_v_left[1][0]), int(line_v_left[1][1]) ), (int(line_v_left[0][0]), int(line_v_left[0][1])), color, thickness)
    draw_line(image, ( int(line_v_right[1][0]), int(line_v_right[1][1]) ), (int(line_v_right[0][0]), int(line_v_right[0][1])), color, thickness)

    cv2.imshow('image',image)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()