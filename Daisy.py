from flask import Flask, request, jsonify
from flaskext.mysql import MySQL
from flask import render_template
from flask_wtf import FlaskForm
from wtforms import IntegerField, DateField, StringField, validators
from wtforms.validators import (DataRequired,Length)
from flask_bootstrap import Bootstrap
import datetime

mysql = MySQL()
app = Flask(__name__)
bootstrap = Bootstrap(app)

app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'Makaveli'
app.config['MYSQL_DATABASE_DB'] = 'Daisy'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
app.config['SECRET_KEY'] = 'top secret key'
mysql.init_app(app)

conn = mysql.connect()
cursor = conn.cursor()

@app.route('/', methods=['GET', 'POST'])

def home():
	all_employees = []
	cursor.execute("SELECT first_name, last_name, emp_no FROM employees")
	rows = cursor.fetchall()
	columns = [desc[0] for desc in cursor.description]
	for row in rows:
		row = dict(zip(columns,row))
		all_employees.append(row)
	return render_template('index.html', employees = all_employees),200

class RegistrationForm(FlaskForm):
	first_name = StringField('First Name', validators=[DataRequired()])
	last_name = StringField('Last Name', validators=[DataRequired(), Length(min=1, max=25)])

@app.route('/add', methods=['GET', 'POST'])

def add():
	form = RegistrationForm(request.form)
	if (request.method == 'POST'):
			return (request.form['first_name'])
	return render_template('add.html', form=form),200


#ERROR ROUTE
@app.errorhandler(404)

def not_found(error):
	return jsonify({'code':404,'message': 'Not Found'}),404

if __name__ == '__main__':
	app.run('0.0.0.0',port='5000')
