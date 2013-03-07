rhok-plan-generator
===================

Generate Bushfire Survival Plans that include notification functionality


###### Getting setup:

```bash
mysql -u root -p

create user rhok;
grant all on rhok.* to 'rhok'@localhost identified by 'rhok';

git clone https://github.com/jkelabora/rhok-plan-generator.git

cd rhok-plan-generator/

bundle install
be rake db:create
be rake db:migrate
be rake db:seed

bundle exec rails s
```

```
eb start
```
