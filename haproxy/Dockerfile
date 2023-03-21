FROM docker.io/library/haproxy:2.3
RUN rm -rf /run/haproxy/
RUN mkdir /run/haproxy
RUN mkdir /local-health
COPY health.http /local-health/health.http
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg