import mysql.connector
import os
import subprocess


conn = mysql.connector.connect(
    user='root',
    password='sad262829',
    host='localhost',
    database='streamflix'
)
cursor = conn.cursor()

contentID = 'c35'
cursor.execute("SELECT contentCover FROM Content WHERE contentID = %s", (contentID,))
result = cursor.fetchone()

if result:
    cover_path = result[0]
    print(f"Content cover path: {cover_path}")
    
  
    if os.path.exists(cover_path):
       
        subprocess.run(['open', cover_path])
    else:
        print("The file does not exist.")
else:
    print("No cover path found for the given content ID.")


cursor.close()
conn.close()