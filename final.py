from flask import Flask, jsonify
import pymysql

app = Flask(__name__)

@app.route('/data', methods=['GET'])
def get_data():
    # Establish a connection to the MySQL database
    db = pymysql.connect(
        host="67.205.163.33",
        user="",
        password="",
        database=""
    )
    cursor = db.cursor()

    # Execute the SELECT query
    query = "SELECT * FROM Positions"
    cursor.execute(query)

    # Fetch the results and convert them to a dictionary
    results = []
    for row in cursor.fetchall():
        result = {}
        result['column1'] = row[0]
        result['column2'] = row[1]
        # Add more columns as needed
        results.append(result)

    # Close the database connection
    db.close()

    # Return the results as JSON
    return jsonify(results)

if __name__ == '__main__':
    app.run(debug=True)
