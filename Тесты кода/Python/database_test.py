import hashlib # Для хэширования
import pymysql # для работы с MySQL

con = pymysql.connect(host='127.0.0.1', user='root', password='root', db='workshops_ptk')