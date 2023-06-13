# You can run this project using this file
cd DjangoStart
virtualenv venv
source venv/Scripts/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
