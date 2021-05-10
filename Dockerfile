FROM jupyter/base-notebook:latest

WORKDIR /work

USER root
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git \
	apt-get install -y curl \
	apt-get install -y unzip

RUN git clone https://github.com/infraql/pyinfraql

RUN curl -XGET https://storage.googleapis.com/infraql-downloads/infraql_linux_amd64.zip --output infraql_linux_amd64.zip
RUN unzip infraql_linux_amd64.zip
RUN mv infraql /bin
RUN chmod +x /bin/infraql

COPY ./keys /keys

ENV PYTHON_PACKAGES="\
    matplotlib \
    pandas \
	mplfinance \
" 

RUN pip install --upgrade pip \
    && pip install --no-cache-dir $PYTHON_PACKAGES