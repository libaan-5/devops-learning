FROM python:3.8-slim
WORKDIR /app
COPY . .
RUN apt update && \
apt install -y python3-pip python3-venv python-is-python3
EXPOSE 5000
CMD ["python", "app.py"]