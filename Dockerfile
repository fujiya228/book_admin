FROM ruby:2.7.3

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    # && apt-get install -y nodejs yarn gosu \
    && mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

RUN apt-get install -y gosu

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ARG USERNAME=public-user
ARG GROUPNAME=public-user
ARG UID=228
ARG GID=228
ARG PASSWORD=public-user
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENTRYPOINT ["entrypoint.sh"]
# USER $USERNAME
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]