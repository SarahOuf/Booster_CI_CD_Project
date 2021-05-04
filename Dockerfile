FROM python:3
RUN mkdir /app
WORKDIR /app
ADD . /app/
RUN pip install -r requirements.txt
RUN python3 manage.py makemigrations
RUN python3 manage.py migrate
CMD python3 manage.py runserver 0.0.0.0:8000