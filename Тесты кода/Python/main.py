# Импорт библиотек
import flask, flask_restful, flask_wtf # Для создания "сервера"
from forms import admin_signin
import configparser

#############
# Переменные
server = flask.Flask(__name__)
# Получение настроек подвключения к серверу
config = configparser.ConfigParser()
config.read("config.ini")
ServerDB = config['Connect_to_Data_Base']['ServerDB']
UserName = config['Connect_to_Data_Base']['UserName']
Password = config['Connect_to_Data_Base']['Password']
NameDB = config['Connect_to_Data_Base']['NameDB']

@server.route('/admin')
def show_admin_panel():
    form = admin_signin.LoginAdmin()
    return flask.render_template('admin_signin.html', form=form)

if __name__ == '__main__':
    server.run(debug=True)