
from firebase_admin import threading


class Servo:
    def __init__(self):
        self.pointsData = []
        self.callback_done = threading.Event()

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
