FROM azuresdk/azure-cli-python:latest
LABEL maintainer="tstraub@cardinalsolutions.com"

ADD scripts/ scripts/

CMD bash