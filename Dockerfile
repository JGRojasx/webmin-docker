FROM	debian:buster

RUN	apt-get update -y && \
	DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
	wget \
	perl \
	&& rm -rf /var/lib/apt/lists/*


COPY	entrypoint.sh /

EXPOSE	10000

CMD [ "bash", "/entrypoint.sh", "-D" ]
