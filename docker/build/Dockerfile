FROM ruby:2.1.5

RUN apt-get update -y && \
  apt-get install -y nodejs python python-setuptools locales && \
  easy_install sphinx

ADD docker/build/scripts /usr/src/scripts
ADD docker/build/config /usr/src/config
ADD Gemfile /usr/src/Gemfile
ADD Gemfile.lock /usr/src/Gemfile.lock

RUN bundle install --gemfile=/usr/src/Gemfile

EXPOSE 4000

CMD ["/bin/bash", "/usr/src/scripts/preview.sh"]
