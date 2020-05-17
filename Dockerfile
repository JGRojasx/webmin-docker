FROM	alpine as builder

RUN	apk add wget && cd /root && wget https://download.webmin.com/jcameron-key.asc

FROM	debian:buster

COPY --from=builder /root/jcameron-key.asc /tmp/

RUN	rm /etc/apt/apt.conf.d/docker-gzip-indexes && \
	apt-get update -y && \
	DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y ca-certificates wget nano procps gnupg1 && \
	echo deb https://download.webmin.com/download/repository sarge contrib >> /etc/apt/sources.list && \
	 cd /tmp && apt-key add jcameron-key.asc && \
	apt-get update -y && \
	DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
	apt-transport-https \
	webmin \
	&& rm -rf /var/lib/apt/lists/*

RUN	echo 'root:admin' | chpasswd

COPY	entrypoint.sh /

EXPOSE	10000

CMD [ "bash", "/entrypoint.sh", "-D" ]
