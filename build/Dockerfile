FROM python:3.7-alpine3.13

COPY app/ /app

WORKDIR /app

RUN pip install -r requirements.txt

EXPOSE 8000

CMD ["gunicorn", "--log-level", "debug", "--bind", "0.0.0.0:8000", "api:app"]
