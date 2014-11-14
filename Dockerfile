FROM phusion/passenger-ruby21
MAINTAINER Kavinder "kavinderd@gmail.com"

ENV HOME /root
ENV RAILS_ENV production

CMD ["/sbin/my_init"]

RUN rm -f /etc/servic/nginx/down
RUN rm /etc/nginx/sites-enabled/default
ADD nginx.conf /etc/nginx/sites-enabled/ergo.conf

ADD . /home/app/ergo
WORKDIR /home/app/ergo

RUN chown -R app:app /home/app/ergo
RUN sudo -u app bundle install --deployment
RUN sudo -u app RAILS_ENV=production rake assets:precompile

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
