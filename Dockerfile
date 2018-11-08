FROM jupyter/base-notebook:61d8aaedaeaf
MAINTAINER "chestercheng <chester7864@gmail.com>"

ADD * /home/$NB_USER/work/

# Intstall jupyter extensions
USER root
RUN pip install 'matplotlib==3.0.0' && \
    pip install 'numpy==1.15.3' && \
    pip install 'jupyter-contrib-nbextensions==0.5.0'
RUN jupyter contrib nbextension install --system && \
    jupyter nbextension enable runtools/main
RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER $NB_USER
