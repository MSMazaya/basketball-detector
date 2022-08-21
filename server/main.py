import cv2
from firebase_admin import threading
from models.camera import Camera
from models.db import DB
from models.servo import Servo


def createCamera():
    bufferThickness = 30
    orangeLower = (10, 200, 20)
    orangeUpper = (15, 255, 255)
    return Camera(orangeLower, orangeUpper, bufferThickness)


def interruptIR(db, position):
    # t = threading.Thread(target=db.addPoint,
    #                      args=([position[0], position[1]]))
    db.addPoint(position)


def registerInterrupt(fn, args):
    pass


def main(debug=False):
    camera = createCamera()
    db = DB()
    servo = Servo()
    camera.startCapture()

    db.listenToUpdate(servo.getPointsData)
    
    registerInterrupt(interruptIR, args=(db, camera.getBallPosition()))
    
    while True:
        if(servo.isReady()):
            position = camera.getBallPosition()
        
            if position is not None:
                servo.searchForBall()
        
            if(debug):
                # Showing frame + give ball trailing line
                camera.trackBall(position)
        
            key = cv2.waitKey(1) & 0xFF
        
            if key == ord("q"):
                break

    camera.destroy()


main(debug=True)
