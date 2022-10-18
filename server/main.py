import cv2
from models.camera import Camera
from models.db import DB
from models.ir_sensor import IRSensor
from models.utils import getIP

def createCamera():
    bufferThickness = 30
    orangeLower = (10, 200, 20)
    orangeUpper = (15, 255, 255)
    return Camera(orangeLower, orangeUpper, bufferThickness)

db = DB()
db.changeIP(getIP())
ir = IRSensor(23)

def callback(id):
    position = camera.getBallPosition()
    if position != None:
        x,y = position
        db.addPoint(camera.detectPosition(x, y))

ir.interrupt_callback(callback)

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