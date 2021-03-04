#既存のプロジェクトのrubyのバージョンを指定
FROM ruby:2.7.2-alpine3.12

ENV TZ="Asia/Tokyo" \
    LANG="C.UTF-8" \
    APP_ROOT="/app" \
    ENTRYKIT_VERSION="0.4.0"

# 作業フォルダの設定
WORKDIR $APP_ROOT

#エントリーキットの導入
RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && mv entrykit /bin/entrykit \
    && chmod +x /bin/entrykit \
    && entrykit --symlink

RUN apk update \
&&  apk add --no-cache \
    alpine-sdk \
    bash \
    build-base \
    imagemagick \
    less \
    mysql-client \
    mysql-dev \
    nodejs \
    python2 \
    tzdata \
    vim \
    yarn

# 既存railsプロジェクトをコンテナ内にコピー
COPY . $APP_ROOT

ENTRYPOINT [ \
  "prehook", "bundle install -j4 --quiet", "--", \
  "prehook", "yarn install --check-files --ignore-optional", "--"]
