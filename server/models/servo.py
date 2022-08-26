port RPi.GPIO as GPIO
from firebase_admin import threading


class Servo:
    def __init__(self, pin):
        GPIO.setmode(GPIO.BCM)
        GPIO.setwarnings(False)

        self.pointsData = []
        self.callback_done = threading.Event()

        GPIO.setup(pin, GPIO.OUT)

        self.pwm_channel = GPIO.PWM(pin, 50)
        self.pwm_channel.start(0)

    def getPointsData(self, col_snapshot, changes, read_time):
        newData= []
        for doc in col_snapshot:
            newData.append(doc.to_dict())
        self.pointsData = newData
        print(self.pointsData)
        self.callback_done.set()

    def isReady(self):
        return len(self.pointsData)

    def searchForBall(self):
        pass

    def goToAngle(self, angle):
        self.pwm_channel.ChangeDutyCycle(2+(float(angle)/18))
