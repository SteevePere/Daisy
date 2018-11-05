"""Main app server"""

# pylint: disable=W0312
# pylint: disable=C0301
# pylint: disable=C0326
# pylint: disable=C0325
# pylint: disable=C0111
# pylint: disable=C0103
# pylint: disable=R0903
# pylint: disable=W0621
# pylint: disable=W0622
# pylint: disable=W0613

# -- IMPORTS --
from flask import Flask, request, jsonify, redirect, url_for, render_template
from flaskext.mysql import MySQL
from flask_wtf import FlaskForm
from wtforms import StringField
from wtforms.validators import (DataRequired, Length)
from flask_bootstrap import Bootstrap

# -- INIT OBJECTS --

mysql = MySQL()
app = Flask(__name__)
bootstrap = Bootstrap(app)

# -- APP CONFIG --

app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'Makaveli'
app.config['MYSQL_DATABASE_DB'] = 'Daisy'
app.config['MYSQL_DATABASE_HOST'] = 'mysql'
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
		return render_template('add.html', form=form, empno=empno),200
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
@app.route('/edit/<empno>/<gender>/<firstname>/<lastname>/<bdate>', methods=['GET', 'POST'])

def edit(empno,gender,firstname,lastname,bdate):
	form = RegistrationForm(request.form)
	return render_template('edit.html', empno=empno, gender=gender, firstname=firstname, lastname=lastname, b_date=bdate, form=form),200

#MODIFY ENTRY
@app.route('/modify/<empno>', methods=['GET', 'POST'])

def modify(empno):
	newfirstname = str(request.form['first_name'])
	newlastname = str(request.form['last_name'])
	newgender = str(request.form['gender'])
	newbdate = str(request.form['birth_date'])
	empno=empno
	cursor.execute("UPDATE employees SET gender = (%s), first_name = (%s), last_name = (%s), birth_date = (%s) WHERE emp_no = (%s)",(newgender, newfirstname, newlastname, newbdate, empno))
	conn.commit()
	return redirect(url_for('home'))

#ERROR ROUTE
@app.errorhandler(404)

def not_found(error):
	return jsonify({'code':404,'message': 'Not Found'}),404

if __name__ == "__main__": # nosec
    app.run(host='0.0.0.0', port=5001) # nosec
