- PostgreSQL кластер мастер - реплика, с балансировкой запросов. Развернутый на Vagrant.
- все виртуальные машины (мастер-нода, нода-реплика, балансировщик) развернуты в приватной сети, на хосте-балансировщике проброшены порты 5432 -> 6432, 5433 -> 6433
- пример подключения к БД мастера с локального хоста `psql -h localhost -d postgres -U postgres -p 6432`
- примонтированные диски:
<img width="375" height="210" alt="изображение" src="https://github.com/user-attachments/assets/b4d2f569-43ab-4b39-ac51-29dfb51e8b4d" />

- демонстрация проброса портов:
<img width="727" height="156" alt="изображение" src="https://github.com/user-attachments/assets/e1d7cee5-32c8-452b-b9f3-31aab620e1c1" />
