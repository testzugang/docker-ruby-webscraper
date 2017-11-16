FROM ruby:2.4.1-slim

RUN set -x \
    && apt-get update \
    && apt-get install -y wget libfontconfig1 ruby-dev zlib1g-dev liblzma-dev build-essential git expect-dev \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://github.com/just-containers/s6-overlay/releases/download/v1.19.1.1/s6-overlay-amd64.tar.gz --no-check-certificate --quiet -O /tmp/s6-overlay.tar.gz \
    && tar xvfz /tmp/s6-overlay.tar.gz -C / \
    && rm -f /tmp/s6-overlay.tar.gz \    
    && wget -O /tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2 https://github.com/Medium/phantomjs/releases/download/v2.1.1/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    && md5sum /tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    | grep -q "1c947d57fce2f21ce0b43fe2ed7cd361" \
    && tar -xjf /tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /tmp \
    && rm -rf /tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    && mv /tmp/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs \
    && rm -rf /tmp/phantomjs-2.1.1-linux-x86_64 \
    && echo 'gem: --no-document' >> ~/.gemrc \
    && gem install nokogiri -v '~> 1.8' \
    && gem install capybara \
    && gem install poltergeist

WORKDIR /usr/app
COPY run.sh /
ENTRYPOINT ["/run.sh"]