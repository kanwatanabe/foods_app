FROM ruby:2.6.3

ARG AWS_IAM_ACCESS_KEY
ARG AWS_IAM_ACCESS_KEY_ID
ARG SECRET_KEY_BASE

ENV AWS_IAM_ACCESS_KEY $AWS_IAM_ACCESS_KEY
ENV AWS_IAM_ACCESS_KEY_ID $AWS_IAM_ACCESS_KEY_ID
ENV SECRET_KEY_BASE $SECRET_KEY_BASE

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \        
                       nodejs \        
                       vim \
                       default-mysql-client  

#yarn インストール
RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn  

# 作業ディレクトリの作成、設定
RUN mkdir /foods_app
##作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /foods_app 
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileを追加する
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileのbundle install
RUN gem install bundler
RUN bundle install
ADD . $APP_ROOT

RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids

RUN bundle exec rails assets:precompile RAILS_ENV=production
