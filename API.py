from flask import Flask, jsonify
import pymysql

app = Flask(__name__)
db = pymysql.connect(
        host="67.205.163.33",
        user="",
        password="",
        database=""
    )
cursor = db.cursor()


@app.route('/positions', methods=['GET'])
def get_positions():
    # Execute the SELECT query
    query = "SELECT * FROM Positions"
    cursor.execute(query)

    # Fetch the results and convert them to a dictionary
    results = []
    for row in cursor.fetchall():
        result = {}
        result['index'] = row[0]
        result['name'] = row[1]
        # Add more columns as needed
        results.append(result)

    # Return the results as JSON
    return jsonify(results)


@app.route('/customers', methods=['GET'])
def get_customers():
    # Execute the SELECT query
    query = "SELECT * FROM Customers"
    cursor.execute(query)

    # Fetch the results and convert them to a dictionary
    results = []
    for row in cursor.fetchall():
        result = {}
        result['index'] = row[0]
        result['name'] = row[1]
        result['email'] = row[2]
        result['phone'] = row[3]
        result['gender'] = row[4]
        result['DOB'] = row[5]
        result['join_date'] = row[6]
        result['membership_type'] = row[7]
        # Add more columns as needed
        results.append(result)

    # Return the results as JSON
    return jsonify(results)

@app.route('/services', methods=['GET'])
def get_services():
    # Execute the SELECT query
    query = "SELECT * FROM Services"
    cursor.execute(query)

    # Fetch the results and convert them to a dictionary
    results = []
    for row in cursor.fetchall():
        result = {}
        result['index'] = row[0]
        result['name'] = row[1]
        result['description'] = row[2]
        result['price_per_session'] = row[3]
        # Add more columns as needed
        results.append(result)

    # Return the results as JSON
    return jsonify(results)


if __name__ == '__main__':
    app.run(debug=True)
