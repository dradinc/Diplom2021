from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField
from wtforms.validators import DataRequired

class LoginAdmin(FlaskForm):
    login = StringField('Login', valodators=[DataRequired()])
    password =  PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Sign In')