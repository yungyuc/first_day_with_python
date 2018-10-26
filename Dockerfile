FROM python:3.7.0
MAINTAINER "chestercheng <chester7864@gmail.com>"

# Install requirements
RUN pip install matplotlib==3.0.0
RUN pip install numpy==1.15.3
RUN pip install ipykernel==5.1.0
RUN pip install ipython==7.0.1
RUN pip install jupyter==1.0.0
RUN pip install jupyter-contrib-nbextensions==0.5.0

# Intstall jupyter extensions
RUN jupyter contrib nbextension install --system
RUN jupyter nbextension enable runtools/main

# Add Tini. Tini operates as a process subreaper for jupyter. This prevents
# kernel crashes.
ENV TINI_VERSION=v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini \
    /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

# Create a non-root user
ENV NB_USR=pyusr \
    NB_GRP=pyhug
RUN groupadd -r ${NB_GRP}
RUN useradd --no-log-init --create-home -r -g ${NB_GRP} ${NB_USR}

# Running jupyter notebook as non-root user
USER ${NB_USR}
EXPOSE 8888
WORKDIR /home/${NB_USR}
ADD * ./
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0"]
