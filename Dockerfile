FROM python:3.9-slim-bullseye


RUN apt-get -y update

# see https://serverfault.com/a/992421
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ="America/New_York"

RUN apt-get install -y build-essential libopencv-dev python3-opencv git cmake && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
WORKDIR /app

RUN pip install --upgrade pip setuptools==57.5.0 cython==0.29.21
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
RUN pip list

ENV PYTHONPATH="/app"

CMD ["python", "src/tools/generate_synthetic_data.py"]
