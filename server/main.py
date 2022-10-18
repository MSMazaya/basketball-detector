import cv2
from models.camera import Camera
from models.db import DB
from models.servo import Servo
from models.ir_sensor import IRSensor
import time


def createCamera():
    bufferThickness = 30
    orangeLower = (10, 200, 20)
    orangeUpper = (15, 255, 255)
    return Camera(orangeLower, orangeUpper, bufferThickness)


camera = createCamera()
db = DB()
servo = Servo()
ir = IRSensor(23)

def callback():
    db.addPoint(camera.getBallPosition())

ir.interrupt_callback(callback)

camera.startCapture()

db.listenToUpdate(servo.getPointsData)

while True:
    if(servo.isReady()):
        position = camera.getBallPosition()

        if position is None:
            servo.searchForBall()

        # Showing frame + give ball trailing line
        camera.trackBall(position)

        key = cv2.waitKey(1) & 0xFF

        if key == ord("q"):
            break

    camera.destroy()

