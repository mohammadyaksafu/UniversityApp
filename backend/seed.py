from pymongo import MongoClient
import os
from dotenv import load_dotenv

load_dotenv()
MONGO_URI = os.getenv("MONGO_URI", "mongodb://localhost:27017/university_db")

client = MongoClient(MONGO_URI)
db = client["university_db"]
students_collection = db["students"]
events_collection = db["events"]

# Sample student interests
students_collection.insert_one({
    "student_id": "12345",
    "name": "John Doe",
    "interests": {
        "Technology": 0.9,
        "Music": 0.2,
        "Sports": 0.7,
        "Literature": 0.5
    }
})

print("✅ Sample student data inserted!")
