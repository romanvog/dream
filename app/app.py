from flask import Flask, jsonify, request
import json
import requests

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hi there!'

@app.route('/json')
def get_json():
    response = requests.get('https://jsonplaceholder.typicode.com/todos')
    return jsonify(response.json())

@app.route('/json/user/<user_id>', methods=['GET'])
def get_user_id(user_id):
    response = requests.get('https://jsonplaceholder.typicode.com/todos').json()
    user_data = [item for item in response if item['userId'] == int(user_id)]
    return user_data


if __name__ == '__main__':
    app.run(port=8080, debug=True, host='0.0.0.0')