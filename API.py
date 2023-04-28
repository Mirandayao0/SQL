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

@app.route('/positions', methods=['POST'])
def insert_positions():
    # parse the incoming JSON data
    data = request.json

    # validate the data
    if 'name' not in data:
        return 'Invalid data', 400

    # insert the data into the MySQL database
    query = 'INSERT INTO Positions (name) VALUES (%s)'
    cursor.execute(query, (data['name']))
    # db.commit()

    return 'Positions Data inserted successfully', 201

@app.route('/positions/<index>', methods=['DELETE'])
def delete_positions(index):
    # delete the data from the MySQL database
    query = 'DELETE FROM Positions WHERE position_id = %s'
    cursor.execute(query, index)
    return 'Positions Data deleted successfully', 204

@app.route('/positions/<index>', methods=['UPDATE'])
def update_positions(index):
    # parse the incoming JSON data
    data = request.json
    # validate the data
    if 'name' not in data :
        return 'Invalid data', 400

    # insert the data into the MySQL database
    query = 'UPDATE Positions SET name = %s WHERE position_id = %s'
    cursor.execute(query, (data['name'],index))
    # db.commit()

    return 'Positions Data update successfully', 201
    

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


@app.route('/customers', methods=['POST'])
def insert_customers():
    # parse the incoming JSON data
    data = request.json

    # validate the data
    if 'name' not in data or 'email' not in data or 'phone' not in data or 'gender' not in data or 'DOB' not in data or 'join_date' not in data or 'membership_type' not in data:
        return 'Invalid data', 400

    # insert the data into the MySQL database
    query = 'INSERT INTO Customers (name, email, phone,gender,date_of_birth,join_date,membership_type) VALUES (%s, %s, %s,%s,%s,%s,%s)'
    cursor.execute(query, (data['name'], data['email'], data['phone'],data['gender'],data['DOB'],data['join_date'],data['membership_type']))
    # db.commit()

    return 'Customers Data inserted successfully', 201

@app.route('/customers/<index>', methods=['DELETE'])
def delete_customers(index):
    # delete the data from the MySQL database
    query = 'DELETE FROM Customers WHERE customer_id = %s'
    cursor.execute(query, index)
    return 'Customers Data deleted successfully', 204

@app.route('/customers/<index>', methods=['UPDATE'])
def update_customers(index):
    # parse the incoming JSON data
    data = request.json
    # validate the data
    if 'name' not in data or 'email' not in data or 'phone' not in data or 'gender' not in data or 'DOB' not in data or 'join_date' not in data or 'membership_type' not in data:
        return 'Invalid data', 400

    # insert the data into the MySQL database
    query = 'UPDATE Customers SET name = %s, email = %s, phone = %s,gender = %s,date_of_birth = %s,join_date = %s, membership_type = %s WHERE customer_id = %s'
    cursor.execute(query, (data['name'], data['email'], data['phone'],data['gender'],data['DOB'],data['join_date'],data['membership_type'], index))
    # db.commit()

    return 'Customers Data update successfully', 201
    


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

@app.route('/services', methods=['POST'])
def insert_services():
    # parse the incoming JSON data
    data = request.json

    # validate the data
    if 'name' not in data or 'description' not in data or 'price_per_session' not in data:
        return 'Invalid data', 400

    # insert the data into the MySQL database
    query = 'INSERT INTO Services (name, description, price_per_session) VALUES (%s, %s, %s)'
    cursor.execute(query, (data['name'], data['description'], data['price_per_session']))
    # db.commit()

    return 'Services Data inserted successfully', 201

@app.route('/services/<index>', methods=['DELETE'])
def delete_services(index):
    # delete the data from the MySQL database
    query = 'DELETE FROM Services WHERE service_id = %s'
    cursor.execute(query, index)
    return 'Services Data deleted successfully', 204

@app.route('/services/<index>', methods=['UPDATE'])
def update_services(index):
    # parse the incoming JSON data
    data = request.json

    # validate the data
    if 'name' not in data or 'description' not in data or 'price_per_session' not in data:
        return 'Invalid data', 400

    # insert the data into the MySQL database
    query = 'UPDATE Services SET name = %s, description = %s, price_per_session = %s WHERE service_id = %s'
    cursor.execute(query, (data['name'], data['description'], data['price_per_session'], index))
    # db.commit()

    return 'Services Data update successfully', 201



if __name__ == '__main__':
    app.run(debug=True)

