import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

class DB():
    def __init__(self):
        cred = credentials.Certificate("./secret.json")
        app = firebase_admin.initialize_app(cred)
        self.db = firestore.client(app)

    def addPoint(self, position):
        docs = self.db.collection(u'points').where(u'position', u'==', position).stream()

        for doc in docs:
            doc_data = doc.to_dict()
            score = doc_data['score']
            self.db.collection(u'points').document(doc.id).update({'score': score+1})

    def changeIP(self, newIP):
        self.db.collection(u'config').document(u'hardware').set({'ip': newIP})

    def listenToUpdate(self, func):
        coll_ref = self.db.collection(u'points')

        col_watch = coll_ref.on_snapshot(func)

        print(col_watch)
