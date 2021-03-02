from flask import Flask, jsonify
from flask_restful import Api, Resource, reqparse
import random
app = Flask(__name__)

#
import pymysql # для работы с MySQL
#

#api = Api(app)

# Просто GET-метод
@app.route('/index/test', methods=['GET'])
def index():
    return jsonify({'id': 'А ВОТ НИЧЕГО И НЕТ', 'name': 'TEST ONE'})

# Метод GET с условием
@app.route('/index/test/<int:test_id>', methods=['GET'])
def index2(test_id):
    return jsonify({'id': test_id, 'name': 'TEST ONE'})

# Старт "сервера"
if __name__ == '__main__':
    app.run(debug=True)