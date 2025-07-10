FROM python:3.11-slim-buster

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
        default-libmysqlclient-dev \
        libjpeg62-turbo-dev \
        zlib1g-dev \
        libwebp-dev \
        curl \
        vim \
        net-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install gunicorn

ENV PATH="/app/scripts:${PATH}"

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "crm.wsgi:application"]
