FROM nginx:1.19.6

ENV TZ="Asia/Tokyo"

RUN rm -f /etc/nginx/conf.d/*

ADD docker/nginx/nginx.conf /etc/nginx/conf.d/webapp.conf

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
