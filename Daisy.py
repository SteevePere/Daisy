# -- IMPORTS --

from flask import Flask, request, jsonify, redirect, url_for
from flaskext.mysql import MySQL
from flask import render_template
from flask_wtf import FlaskForm
from wtforms import IntegerField, DateField, StringField, RadioField, validators
from wtforms.validators import (DataRequired,InputRequired,Length)
from flask_bootstrap import Bootstrap
import datetime, time

# -- INIT OBJECTS --

mysql = MySQL()
app = Flask(__name__)
bootstrap = Bootstrap(app)

# -- APP CONFIG --

app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'Makaveli'
app.config['MYSQL_DATABASE_DB'] = 'Daisy'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
app.config['SECRET_KEY'] = 'top secret key'
mysql.init_app(app)

# -- MYSQL OBJECTS --

conn = mysql.connect()
cursor = conn.cursor()

# -- CUSTOM CLASSES --

#EMPLOYEE FORM
class RegistrationForm(FlaskForm):
	first_name = StringField('First Name', validators=[DataRequired(), Length(min=1, max=15, message="Max length 15 characters")])
	last_name = StringField('Last Name', validators=[DataRequired(), Length(min=1, max=15, message="Max length 15 characters")])

# -- ROUTES --

#INDEX
@app.route('/', methods=['GET', 'POST'])
@app.route('/list', methods=['GET']) #REST

def home():
	all_employees = []
	cursor.execute("SELECT first_name, last_name, emp_no, gender, birth_date FROM employees")
	rows = cursor.fetchall()
	columns = [desc[0] for desc in cursor.description]
	for row in rows:
		row = dict(zip(columns,row))
		if (row["gender"] == "M"):
			row["gender"] = "Mr."
		else:
			(row["gender"]) = "Ms."
		all_employees.append(row)
	if(request.path == '/list'): #REST
			return jsonify({'code':200, 'message':'OK', 'Employees':all_employees}),200
	return render_template('index.html', employees = all_employees),200

@app.route('/search', methods=['GET', 'POST'])

def search():
	employees = []
	message = ""
	search = True
	no_match = False
	input = str(request.form.get("search",""))
	input = '%' + input + '%'
	cursor.execute("SELECT first_name, last_name, emp_no, gender FROM employees WHERE (last_name LIKE (%s) OR first_name LIKE (%s) OR emp_no LIKE (%s))",(input, input, input))
	rows = cursor.fetchall()
	columns = [desc[0] for desc in cursor.description]
	for row in rows:
		row = dict(zip(columns,row))
		if (row["gender"] == "M"):
			row["gender"] = "Mr."
		else:
			(row["gender"]) = "Ms."
		employees.append(row)
	if (employees == []):
		no_match = True
		message = "No employees match your search!"
	return render_template('index.html', employees = employees, message = message, search = search, no_match = no_match),200

#ADD ENTRY
@app.route('/add', methods=['GET', 'POST'])

def add():
	form = RegistrationForm(request.form)
	if (request.method == 'POST'):
		gender = str(request.form['gender'])
		firstname = str(request.form['first_name'])
		lastname = str(request.form['last_name'])
		b_date = str(request.form['birth_date'])
		cursor.execute("SELECT MAX(emp_no) FROM employees")
		top_emp = cursor.fetchall()
		empno = top_emp[0][0] + 1
		cursor.execute("INSERT INTO employees (emp_no, gender, first_name, last_name, birth_date) VALUES ((%s), (%s), (%s), (%s), (%s))",(empno, gender, firstname, lastname, b_date))
		conn.commit()
		return redirect(url_for('home'))
	return render_template('add.html', form=form),200

#REST ADD
@app.route('/create', methods=['GET','POST'])

def create():
	if (request.method == 'POST'):
		if (str(request.headers.get('Content-Type')) != 'application/x-www-form-urlencoded'):
			return jsonify({'message':'Unsupported Media Type','code':415}),415
		firstname = str(request.form['first_name'])
		lastname = str(request.form['last_name'])
		cursor.execute("SELECT MAX(emp_no) FROM employees")
		top_emp = cursor.fetchall()
		empno = top_emp[0][0] + 1
		cursor.execute("INSERT INTO employees (emp_no, first_name, last_name) VALUES ((%s), (%s), (%s))",(empno, firstname, lastname))
		conn.commit()
		return jsonify({'code':201, 'message':'Created'}),201
	return jsonify({'code':404,'message': 'Not Found'}),404

#DELETE ENTRY
@app.route('/delete/<empno>', methods=['GET', 'POST'])

def delete(empno):
	if (request.method == 'POST'):
		cursor.execute("DELETE FROM employees WHERE emp_no = (%s)",(empno))
		conn.commit()
	return redirect('/')

#EDIT PAGE
@app.route('/edit/<empno>/<gender>/<firstname>/<lastname>', methods=['GET', 'POST'])

def edit(empno,gender,firstname,lastname):
	form = RegistrationForm(request.form)
	return render_template('edit.html', empno=empno, gender=gender, firstname=firstname, lastname=lastname, form=form),200

#MODIFY ENTRY
@app.route('/modify/<empno>', methods=['GET', 'POST'])

def modify(empno):
	newfirstname = str(request.form['first_name'])
	newlastname = str(request.form['last_name'])
	newgender = str(request.form['gender'])
	empno=empno
	cursor.execute("UPDATE employees SET gender = (%s), first_name = (%s), last_name = (%s) WHERE emp_no = (%s)",(newgender, newfirstname, newlastname, empno))
	conn.commit()
	return redirect(url_for('home'))

#ERROR ROUTE
@app.errorhandler(404)

def not_found(error):
	return jsonify({'code':404,'message': 'Not Found'}),404

# -- APP ENGINE --

if __name__ == '__main__':
	app.run('0.0.0.0',port='5000')
