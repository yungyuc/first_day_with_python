FROM jupyter/base-notebook:17aba6048f44
MAINTAINER "chestercheng <chester7864@gmail.com>"

# Intstall jupyter extensions
USER root
RUN pip install 'matplotlib==3.0.0' && \
    pip install 'numpy==1.15.3' && \
    pip install 'jupyter-contrib-nbextensions==0.5.0'
RUN jupyter contrib nbextension install --system && \
    jupyter nbextension enable runtools/main
RUN fix-permissions $CONDA_DIR

USER $NB_USER
