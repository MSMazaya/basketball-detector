import RPi.GPIO as GPIO
import sys
import signal

class IRSensor:
    def __init__(self, pin):
        self.pin = pin
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)

    def interrupt_callback(self, callback):
        GPIO.add_event_detect(self.pin, GPIO.FALLING, callback=callback, bouncetime=100)

    def signal_handler(self, sig, frame):
        GPIO.cleanup()
        sys.exit(0)
