FROM azuresdk/azure-cli-python:latest
LABEL maintainer="tstraub@cardinalsolutions.com"

COPY scripts/ scripts/
# COPY bashrc.sh bashrc.sh
# RUN chmod +x bashrc.sh
# RUN pwd
# RUN ls -ll
# RUN bashrc.sh
# RUN /bin/bash -c 'for f in /scripts/*; \
#     do source $f; \
#     done;'
RUN echo -e "\
for f in /scripts/*; \
do chmod a+x \$f; source \$f; \
done;" > ~/.bashrc

CMD bash


# for f in /scripts/*
# do
#   echo sourcing $f
#   # source $f;
# done