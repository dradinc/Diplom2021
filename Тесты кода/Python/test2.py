import pymysql # для работы с MySQL
from flask import Flask, jsonify, request
from flask_restful import Api, Resource, reqparse

app = Flask(__name__)
#con = pymysql.connect(host='127.0.0.1', user='root', password='root', db='workshops_ptk')

#@app.route('/auth/login', methods=['POST'])
#def auth_login():
#    parameters = request.get_json()
#    return parameters
#
#    with con:
#        cur = con.cursor()

if __name__ == '__main__':
    app.run(debug=True)
