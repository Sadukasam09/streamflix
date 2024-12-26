from flask import Flask, jsonify, request
import mysql.connector
from database import connect_db  # If you're using a separate database.py

app = Flask(__name__)

@app.route('/api/recommendations/<userID>', methods=['GET'])
def get_recommendations(userID):
	try:
		# Connect to the database
		db = connect_db()
		cursor = db.cursor()

		# Get user's liked genres
		liked_genres_query = """
			SELECT DISTINCT g.genreID 
			FROM userInteractions 
			JOIN content_genre cg ON userInteractions.contentID = cg.contentID
			JOIN genre g ON cg.genreID = g.genreID
			WHERE userInteractions.userID = %s AND userInteractions.interactionType = 'like'
		"""
		cursor.execute(liked_genres_query, (userID,))
		liked_genres = [row[0] for row in cursor.fetchall()]

		# Check if liked genres are found
		if not liked_genres:
			return jsonify({"error": "No liked genres found for this user."}), 404

		# Recommend content from liked genres that the user hasn't interacted with
		recommend_query = """
			SELECT c.contentID, c.title
			FROM content c
			JOIN content_genre cg ON c.contentID = cg.contentID
			WHERE cg.genreID IN ({}) AND c.contentID NOT IN (
				SELECT contentID FROM userInteractions WHERE userID = %s
			)
			LIMIT 10  -- Adjust the limit as needed
		""".format(','.join(['%s'] * len(liked_genres)))

		# Combine lists for query parameters
		query_params = liked_genres + [userID]
		
		# Execute the query
		cursor.execute(recommend_query, query_params)
		recommendations = [{"contentID": row[0], "title": row[1]} for row in cursor.fetchall()]

		# Return recommendations as JSON
		return jsonify(recommendations)

	except mysql.connector.Error as err:
		return jsonify({"error": f"Database error: {err}"}), 500

	finally:
		# Close the database connection
		if cursor:
			cursor.close()
		if db:
			db.close()

if __name__ == '__main__':
	app.run(debug=True)
 
 
 
 
 
import requests
response = requests.get('http://127.0.0.1:5000/api/recommendations/u2')
print(response.json())