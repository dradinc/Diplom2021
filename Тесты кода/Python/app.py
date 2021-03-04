from flask import Flask, redirect, render_template, url_for, request, flash
from flask_sqlalchemy import SQLAlchemy
import configparser
import hashlib

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
app.secret_key = 'sercet_key'
app.config['SESSION_TYPE'] = 'o da'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///app.db'  # Конфинупация приложения используемая для работы с базой данных
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
appDataBase = SQLAlchemy(app)  # Переменная для взаимодействия с базой данных
config = configparser.ConfigParser()  # Создаём переменную для работы с конфигурациями
config.read('config.ini')  # Читаем данные конфигурации


# Классы приложения
class userTable(appDataBase.Model):
    id = appDataBase.Column(appDataBase.Integer, primary_key=True)
    login = appDataBase.Column(appDataBase.String(35), nullable=False)
    password = appDataBase.Column(appDataBase.String(64), nullable=False)

    def __repr__(self):
        return '<userTable %r>' % self.id

    def get_id(self):
        return self.id

    def get_login(self):
        return self.login

    def get_password(self):
        return self.password


@app.route('/')
def OpenSite():
    return redirect('/admin')


@app.route('/admin', methods=['POST', 'GET'])
def AdminPage():
    if request.method == 'POST':
        login = request.form["login"]
        password = hashlib.sha512(request.form["password"].encode('utf-8'))

        try:
            users = userTable.query.all()
            for user in users:
                if (user.get_login() == login) and (user.get_password() == password.hexdigest()):
                    return 'Успешная авторизация'
                    break
                else:
                    flash('Логин или пароль введены не верно!')
                    return redirect('/admin')
        except:
            return 'Ошибка'
    elif request.method == 'GET':
        return render_template('admin.html')


# Запускаем приложение
if __name__ == '__main__':
    app.run(debug=True)
