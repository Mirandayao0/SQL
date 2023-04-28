# Fitness Center Management System
This is a course project for INFSCI 2710 Database Management Systems
project link: https://github.com/Mirandayao0/SQL
The Fitness Management System is a Spring Boot application designed to manage a gym's customer, 
employee, and service data. It includes features to manage memberships, transactions, schedules, and more. 
The application provides a RESTful API to interact with the underlying database, 
allowing for easy integration with various clients.

## Features
* Store and manage customer, employee, service, schedule, transaction, payment, membership, invoice, and payment method data
* Perform CRUD operations on the database tables
* Expose a RESTful API for data retrieval and manipulation
* Provide JSON-formatted output for API endpoints

## Setup
- Create conda environment or venv for Python:
- conda env create -f requirement.yml
- Start the API
- conda activate sql
- python API.py
- Open Postman
- Start a new request in a new collection and **add Content-Type=application/json in Headers**

## Class Diagram
![Slide1.jpeg](./Slide1.jpeg)

### select and display data from customers,postions,services
[GET] http://127.0.0.1:5000/services
![display_services](./display/display_services.png)

[GET] http://127.0.0.1:5000/customers
![display_customers](./display/display_customers.png)

[GET] http://127.0.0.1:5000/positions
![display_positions](./display/display_positions.png)

### insert data to services
[post] http://127.0.0.1:5000/services
![insert_services](./insert_update_delete/insert_services.png)

### insert data to customers
[post] http://127.0.0.1:5000/customers
![insert_customers](./insert_update_delete/insert_customers.png)

### insert data to positions
[post] http://127.0.0.1:5000/positions
![insert_positions](./insert_update_delete/insert_positions.png)


### update data to services
[update] http://127.0.0.1:5000/services/1
![update_services](./insert_update_delete/update_services.png)

### update data to customers
[update] http://127.0.0.1:5000/customers/1
![update_customers](./insert_update_delete/update_customers.png)

### update data to positions
[update] http://127.0.0.1:5000/positions/1
![insert_positions](./insert_update_delete/update_positions.png)

### delete data to services
[delete] http://127.0.0.1:5000/services/1
![update_services](./insert_update_delete/delete_services.png)

### delete data to customers
[delete] http://127.0.0.1:5000/customers/1
![update_customers](./insert_update_delete/delete_customers.png)

### delete data to positions
[delete] http://127.0.0.1:5000/positions/1
![insert_positions](./insert_update_delete/delete_positions.png)
