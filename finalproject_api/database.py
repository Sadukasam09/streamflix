import mysql.connector

def connect_db():
    # Replace with your database credentials
    return mysql.connector.connect(
        host="your_database_host",
        user="your_username",
        password="your_password",
        database="finalproject"
    )
