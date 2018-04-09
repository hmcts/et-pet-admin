FROM ministryofjustice/ruby:2.3.3-webapp-onbuild

# Ensure the pdftk package is installed as a prereq for ruby PDF generation
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y pdftk

RUN npm install

EXPOSE 8080

RUN bash -c "DB_ADAPTOR=nulldb bundle exec rake assets:precompile RAILS_ENV=production"

CMD ["./run.sh"]