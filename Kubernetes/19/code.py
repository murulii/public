import os
from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL

app = Flask(__name__)

# Function to read secret values from mounted files
def read_secret(secret_name):
    file_path = os.path.join("/opt/secrets", secret_name)
    try:
        with open(file_path, 'r') as file:
            return file.read().strip()
    except IOError:
        return None

# Configure MySQL from secret files
app.config['MYSQL_HOST'] = read_secret('url') or 'localhost'
app.config['MYSQL_USER'] = read_secret('username') or 'default_user'
app.config['MYSQL_PASSWORD'] = read_secret('password') or 'default_password'
app.config['MYSQL_DB'] = read_secret('db') or 'default_db'

# Initialize MySQL
mysql = MySQL(app)

@app.route('/')
def hello():
    cur = mysql.connection.cursor()
    cur.execute('SELECT name, email FROM data')
    data = cur.fetchall()
    cur.close()
    return render_template('index.html', data=data)

@app.route('/submit', methods=['POST'])
def submit():
    name = request.form.get('name')
    email = request.form.get('email')
    cur = mysql.connection.cursor()
    cur.execute('INSERT INTO data (name, email) VALUES (%s, %s)', (name, email))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('hello'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
