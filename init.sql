create user rhok;
create database rhok;
create database rhok_test;
grant all on rhok.* to 'rhok'@localhost identified by 'rhok';
grant all on rhok_test.* to 'rhok'@localhost identified by 'rhok';