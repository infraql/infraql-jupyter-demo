FROM jupyter/base-notebook:latest

WORKDIR /work

USER root
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git && \
	apt-get install -y curl && \
	apt-get install -y unzip

RUN git clone https://github.com/infraql/pyinfraql

RUN curl -XGET https://storage.googleapis.com/infraql-downloads/infraql_linux_amd64.zip --output infraql_linux_amd64.zip && \
    unzip infraql_linux_amd64.zip && \
    mv infraql /bin && \
    chmod +x /bin/infraql && \
    rm infraql_linux_amd64.zip

COPY ./keys /keys
COPY ./example.ipynb /work

RUN chmod 644 example.ipynb && \
    chown jovyan:users example.ipynb

ENV PYTHON_PACKAGES="\
    matplotlib \
    pandas \
	mplfinance \
" 

RUN pip install --upgrade pip \
    && pip install --no-cache-dir $PYTHON_PACKAGES