FROM python:3.7-alpine3.13

COPY app/ /app

WORKDIR /app

RUN pip install -r requirements.txt

CMD ["gunicorn", "--log-level", "debug", "api:app"]
