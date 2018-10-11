from flask import Flask, request, jsonify
from flaskext.mysql import MySQL
from flask import render_template
from wtforms import Form, IntegerField, DateField, StringField, validators
from flask_bootstrap import Bootstrap

mysql = MySQL()
app = Flask(__name__)
bootstrap = Bootstrap(app)

app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'Makaveli'
app.config['MYSQL_DATABASE_DB'] = 'Daisy'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

conn = mysql.connect()
cursor = conn.cursor()

@app.route('/', methods=['GET', 'POST'])

def home():
	all_employees = []
	cursor.execute("SELECT first_name, last_name, emp_no, birth_date FROM employees")
	rows = cursor.fetchall()
	columns = [desc[0] for desc in cursor.description]
	for row in rows:
		row = dict(zip(columns,row))
		all_employees.append(row)
	return render_template('index.html', employees = all_employees),200

class RegistrationForm(Form):
	emp_no = IntegerField('Employee Number', [validators.Length(min=1, max=25)])
	first_name = StringField('First Name', [validators.Length(min=1, max=25)])
	last_name = StringField('Last Name', [validators.Length(min=1, max=25)])
	birth_date = DateField('Birth Date', [validators.Length(min=1, max=25)])

@app.route('/add', methods=['GET', 'POST'])

def add():
    form = RegistrationForm(request.form)
    return render_template('add.html', form=form),200

@app.route('/add_emp', methods=['POST'])

def add_emp():
	return (request.form['first_name'])

#ERROR ROUTE
@app.errorhandler(404)

def not_found(error):
	return jsonify({'code':404,'message': 'Not Found'}),404

if __name__ == '__main__':
	app.run('0.0.0.0',port='5000')
