FROM swipl/swipl
RUN mkdir /plfiles
WORKDIR /plfiles
VOLUME ["/plfiles"]
ENTRYPOINT ["/bin/bash"]
