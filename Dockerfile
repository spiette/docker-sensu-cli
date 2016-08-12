FROM alpine
 
RUN apk add --update ruby && rm -rf /var/cache/apk/*
 
ENV BUNDLER_VERSION 1.12.3
RUN gem install bundler -v $BUNDLER_VERSION --no-ri --no-rdoc
 
# bundler wants some library that needs core extensions ... but it won't compile
#RUN mkdir -p /usr/lib/ruby/gems/2.2.0/gems/bundler-$BUNDLER_VERSION/lib/io
#RUN touch /usr/lib/ruby/gems/2.2.0/gems/bundler-$BUNDLER_VERSION/lib/io/console.rb
 
# bundler does not want to install as root
RUN bundle config --global silence_root_warning 1
 
RUN mkdir /app
WORKDIR /app
 
ADD Gemfile .
RUN bundler install --binstubs --path vendor
# ADD Gemfile.lock .
# RUN bundle
