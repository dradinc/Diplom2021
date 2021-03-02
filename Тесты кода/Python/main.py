# Импорт библиотек
import flask, flask_restful # Для создания "сервера"

# Переменные
server = flask.Flask(__name__)

# Что-то там

if __name__ == '__main__':
    server.run(debag=True)