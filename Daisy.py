from flask import Flask, request, jsonify
from flaskext.mysql import MySQL
from flask import render_template

mysql = MySQL()
app = Flask(__name__)

app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'Makaveli'
app.config['MYSQL_DATABASE_DB'] = 'Daisy'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

conn = mysql.connect()
cursor = conn.cursor()

@app.route('/')

def home():
	cursor.execute("SELECT first_name FROM employees WHERE emp_no = 10001")
	names = cursor.fetchall()
	for name in names:
		name = name[0]
	return render_template('hello.html', name = name)

#ERROR ROUTE
@app.errorhandler(404)

def not_found(error):
	return jsonify({'code':404,'message': 'Not Found'}),404

if __name__ == '__main__':
	app.run('0.0.0.0',port='5000')
