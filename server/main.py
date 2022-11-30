import cv2
from models.db import DB
from models.camera import Camera
from models.utils import getIP
#
# db = DB()
# db.changeIP(getIP())
#
def createCamera():
    bufferThickness = 30
    orangeLower = (10, 200, 20)
    orangeUpper = (15, 255, 255)
    return Camera(orangeLower, orangeUpper, bufferThickness)


# while True:
#     position = camera.getBallPosition()
#
#     # Showing frame + give ball trailing line
#     camera.trackBall(position)
#
#     key = cv2.waitKey(1) & 0xFF
#
#     if key == ord("q"):
#         break
#
# camera.destroy()


# Web streaming example
# Source code from the official PiCamera package
# http://picamera.readthedocs.io/en/latest/recipes2.html#web-streaming

# camera = createCamera()
#
# camera.startCapture()

# with picamera.PiCamera(resolution='640x480', framerate=24) as camera:

'''
	Author: Igor Maculan - n3wtron@gmail.com
	A Simple mjpg stream http server
'''
import cv2
from PIL import Image
import threading
from http.server import BaseHTTPRequestHandler,HTTPServer
from socketserver import ThreadingMixIn
from io import StringIO,BytesIO
import time
capture=None

class CamHandler(BaseHTTPRequestHandler):
	def do_GET(self):
		if self.path.endswith('.mjpg'):
			print("HEEEEEEEEEEEEEEEEEEEEEEEEY")
			self.send_response(200)
			self.send_header('Content-type','multipart/x-mixed-replace; boundary=--jpgboundary')
			self.end_headers()
			while True:
				try:
					img = camera.getFrame()
					jpg = Image.fromarray(img)
					tmpFile = BytesIO()
					jpg.save(tmpFile,'JPEG')
					self.wfile.write("--jpgboundary".encode())
					self.send_header('Content-type','image/jpeg')
					self.send_header('Content-length',str(tmpFile.getbuffer().nbytes))
					self.end_headers()
					jpg.save(self.wfile,'JPEG')
					time.sleep(0.05)
				except KeyboardInterrupt:
					break
			return
		if self.path.endswith('.html'):
			self.send_response(200)
			self.send_header('Content-type','text/html')
			self.end_headers()
			self.wfile.write('<html><head></head><body>'.encode())
			self.wfile.write('<img src="http://127.0.0.1:8087/cam.mjpg"/>'.encode())
			self.wfile.write('</body></html>'.encode())
			return


class ThreadedHTTPServer(ThreadingMixIn, HTTPServer):
	"""Handle requests in a separate thread."""

def main():
    global camera
    global img

    camera = createCamera()
    camera.startCapture()

    try:
        server = ThreadedHTTPServer(('localhost', 8087), CamHandler)
        print("Started")
        server.serve_forever()
    except KeyboardInterrupt:
        capture.release()
        server.socket.close()

if __name__ == '__main__':
	main()
