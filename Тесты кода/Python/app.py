from flask import Flask, redirect, render_template, url_for, request
from flask_sqlalchemy import SQLAlchemy
import configparser

'''
Импортированные библиотеки:
    - модуль Flask используется для работы и запуска приложения;
    - моудль redirect используется для переадресации;
    - модуль render_template используется для отображения html страниц;
    - модуль url_for используется для взаимодействия с ресурсами из папки static
    - модуль request используется для взаимодействием с данными запросов POST, GET
    - модуль SQLAlchemy используется для работы с базой данных;
    - модуль configparser используется для работы с файлом конфигурации;
'''

# Переменные приложения и их настройки
app = Flask(__name__)  # Создаём переменную приложенияя
app.config[
    'SQLALCHEMY_DATABASE_URI'] = 'sqlite:///app.db'  # Конфинупация приложения используемая для работы с базой данных
appDataBase = SQLAlchemy(app)  # Переменная для взаимодействия с базой данных
config = configparser.ConfigParser()  # Создаём переменную для работы с конфигурациями
config.read('config.ini')  # Читаем данные конфигурации


# Классы приложения
class userTable(appDataBase.Model):
    id = appDataBase.Column(appDataBase.Integer, primary_key=True)
    login = appDataBase.Column(appDataBase.String, nullable=False)
    password = appDataBase.Column(appDataBase.Binary, nullable=False)

    def __repr__(self):
        return '<userTable %r>' % self.id


@app.route('/')
def OpenSite():
    return redirect('/admin')


@app.route('/admin', methods=['POST', 'GET'])
def AdminPage():
    if request.method == 'POST':
        login = request.form["login"]
        password = request.form["password"]
        return login + ' ' + password
    elif request.method == 'GET':
        return render_template('admin.html')


# Запускаем приложение
if __name__ == '__main__':
    app.run(debug=True)
