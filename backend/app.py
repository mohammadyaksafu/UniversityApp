import os
import random
import numpy as np
import pandas as pd
from flask import Flask, jsonify, request
from flask_cors import CORS
from pymongo import MongoClient
from dotenv import load_dotenv
from sklearn.metrics.pairwise import cosine_similarity

# Load environment variables
load_dotenv()

app = Flask(__name__)
CORS(app)

# Connect to MongoDB
MONGO_URI = os.getenv("MONGO_URI")
client = MongoClient(MONGO_URI)
db = client["university_db"]
students_collection = db["students"]
events_collection = db["events"]

# Sample dataset: Events with categories
events = [
    {"id": 1, "title": "AI Workshop", "category": "Technology"},
    {"id": 2, "title": "Music Fest", "category": "Music"},
    {"id": 3, "title": "Sports Meet", "category": "Sports"},
    {"id": 4, "title": "Robotics Hackathon", "category": "Technology"},
    {"id": 5, "title": "Poetry Night", "category": "Literature"},
]

# Convert events to DataFrame
event_df = pd.DataFrame(events)

# Sample user interests
student_interests = {
    "Technology": 0.9,
    "Music": 0.2,
    "Sports": 0.7,
    "Literature": 0.5
}

@app.route("/")
def home():
    return jsonify({"message": "🚀 AI Event Recommendation System Running!"}), 200

# AI Recommendation API
@app.route("/recommend/<student_id>", methods=["GET"])
def recommend_events(student_id):
    # Get student from DB (Assume they have interests stored)
    student = students_collection.find_one({"student_id": student_id})
    
    if not student:
        return jsonify({"error": "Student not found"}), 404

    student_interests = student["interests"]  # Example: {"Technology": 0.8, "Music": 0.5}

    # Convert student interests to array
    student_vector = np.array([student_interests.get(cat, 0) for cat in event_df["category"]])

    # Convert events to category vectors
    event_vectors = np.array([[1 if row["category"] in student_interests else 0] for _, row in event_df.iterrows()])

    # Compute similarity
    similarities = cosine_similarity([student_vector], event_vectors)[0]

    # Rank and recommend events
    event_df["score"] = similarities
    recommended_events = event_df.sort_values(by="score", ascending=False).head(3).to_dict(orient="records")

    return jsonify({"recommended_events": recommended_events}), 200

if __name__ == "__main__":
    PORT = int(os.getenv("PORT", 5000))
    app.run(debug=True, port=PORT)

