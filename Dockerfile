FROM ruby:2.4.1
RUN apt-get update
RUN apt-get install -y --no-install-recommends postgresql-client nodejs
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# We should not need to copy as we are using volume
# however 
# 1) during build time I have got an error if I do not copy (cannot find GemFile) => need to look at https://stackoverflow.com/questions/26050899/how-to-mount-host-volumes-into-docker-containers-in-dockerfile-during-build
# 2) look at notes from last part of following video on 
# performance problems in Mac OS using volumes 
# https://www.youtube.com/watch?v=Soh2k8lCXCA

COPY Gemfile* ./

RUN bundle install

#COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
