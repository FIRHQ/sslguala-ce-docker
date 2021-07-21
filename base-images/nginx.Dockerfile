FROM firhq/sslguala-ui-ce:1.0 as build-stage

FROM nginx
RUN apt-get update -qq && apt-get -y install apache2-utils
ENV RAILS_ROOT /sslguala-ce
WORKDIR $RAILS_ROOT
RUN mkdir log
RUN mkdir dist
COPY --from=build-stage /sslguala-ui-ce/dist dist/
COPY conf/nginx.conf /tmp/docker.nginx
RUN envsubst '$RAILS_ROOT' < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]