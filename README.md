rhok-plan-generator
===================

Generate Bushfire Survival Plans that include notification functionality


###### Getting setup:

```bash
psql -U [admin_role] postgres

postgres>$ create role rhok with CREATEDB LOGIN;

git clone https://github.com/jkelabora/rhok-plan-generator.git

cd rhok-plan-generator/
bundle install
be rake db:create
be rake db:migrate
be rake db:seed

heroku login

export MANDRILL_USERNAME=[username_from_heroku]
export MANDRILL_APIKEY=[api_key_from_heroku]

bundle exec rails s
```