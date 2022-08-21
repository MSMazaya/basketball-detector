import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore


class DB():
    def __init__(self):
        cred = credentials.Certificate("./secret.json")
        app = firebase_admin.initialize_app(cred)
        self.db = firestore.client(app)

    def addPoint(self, point):
        data = {
            u'x': point[0],
            u'y': point[1],
        }

        self.db.collection(u'cities').document(u'LA').set(data)

    def listenToUpdate(self, func):
        coll_ref = self.db.collection(u'points')

        col_watch = coll_ref.on_snapshot(func)

        print(col_watch)
