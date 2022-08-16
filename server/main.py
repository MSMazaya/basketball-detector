import cv2
from utils.detection import Detector


def createDetector():
    bufferThickness = 30
    orangeLower = (10, 200, 20)
    orangeUpper = (15, 255, 255)
    return Detector(orangeLower, orangeUpper, bufferThickness)


def main():
    detector = createDetector()
    detector.startCapture()

    while True:
        position = detector.getBallPosition()

        detector.trackBall(position)

        key = cv2.waitKey(1) & 0xFF

        if key == ord("q"):
            break

    detector.destroy()


main()
