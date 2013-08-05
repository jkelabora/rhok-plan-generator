rhok-plan-generator
===================

Generate Bushfire Survival Plans that include notification functionality


###### Getting setup:

```
mysql -u root -p

create user rhok;
create database rhok;
create database rhok_test;
grant all on rhok.* to 'rhok'@localhost identified by 'rhok';
grant all on rhok_test.* to 'rhok'@localhost identified by 'rhok';

git clone https://github.com/jkelabora/rhok-plan-generator.git

source .profile

cd rhok-plan-generator/

bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed

bundle exec rails s
```

For deploying to AWS there's a bit of stuff involved.. You need the CLI tools for Elastic Beanstalk and some dotfile stuff..
Maybe talk to someone that's worked on this already..

```
eb start
```
