from pymongo import MongoClient

class Connect(object):
    @staticmethod    
    def get_connection():
        return MongoClient("mongodb://admin:admin@localhost:27017/?authSource=admin") 