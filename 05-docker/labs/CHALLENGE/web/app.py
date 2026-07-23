# app.py

from flask import Flask
import redis

app = Flask(__name__)

# Connect to db (service name in docker-compose)
r = redis.Redis(host="db", port=6379, decode_responses=True)

@app.route('/')
def hello_world():
    return f'Hello! Welcome to the web app'

@app.route('/count')
def count_visits():
    visits = r.incr("visits", amount=1)

    return f'Number of visits: {visits}!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5003)

    