# syntax = docker/dockerfile:latest

FROM debian AS init-data
ARG TAR_PATHS

RUN --mount=type=bind,from=data,source=/,target=/data \
	mkdir /init-data && cd data && \
	tar cvf - ${TAR_PATHS} | split --bytes=5GB - /init-data/data.tar.

########################

FROM debian

# Make sure we put everything is separate layers so we dont trigger rate limits
# We abuse wildcard here so it doesn't crash if some files don't exist
COPY --link --from=init-data /init-data/data.tar.aa* /init-data/.
COPY --link --from=init-data /init-data/data.tar.ab* /init-data/.
COPY --link --from=init-data /init-data/data.tar.ac* /init-data/.
COPY --link --from=init-data /init-data/data.tar.ad* /init-data/.
COPY --link --from=init-data /init-data/data.tar.ae* /init-data/.
COPY --link --from=init-data /init-data/data.tar.af* /init-data/.
COPY --link --from=init-data /init-data/data.tar.ag* /init-data/.
COPY --link --from=init-data /init-data/data.tar.ah* /init-data/.
COPY --link --from=init-data /init-data/data.tar.ai* /init-data/.
COPY --link --from=init-data /init-data/data.tar.aj* /init-data/.

COPY <<-EOF copy.sh
	#!/bin/bash

	cd /data

	if [ $(ls -A /data/ | wc -l) -ne 0 ]; then
		cd -
		echo "Data directory already has data skipping"
		exit 0
	fi

	cat /init-data/data.tar.* | tar xvf -
	cd -
EOF
RUN chmod +x copy.sh

CMD [ "./copy.sh" ]