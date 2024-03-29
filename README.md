# Installation

### Config database connection

- rename **_`env`_** to **_`.env`_**
- configure to your own database server

_example inside of_ **_`.env`_** :

```
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_DATABASE=rental_mobil
MYSQL_USER=user
MYSQL_PASSWORD=user
```

---

### Running on localhost

#### Requirements

- `node 18^`
- `npm 8^`

#### Run

```
npm i && npm start
```

access : **_`http://localhost:3000`_**

---

### Running on docker

#### Requirements

- `docker`
- `docker-compose`

#### Config

change value of **_`MYSQL_HOST`_** in **_`.env`_** to **_`rental_mobil_db`_**  
and also change **_`MYSQL_USER`_** & **_`MSYQL_PASSWORD`_**  
_example :_

```
MYSQL_HOST=rental_mobil_db
MYSQL_PORT=3306
MYSQL_DATABASE=rental_mobil
MYSQL_USER=changeme
MYSQL_PASSWORD=changeme
```

> _`don't forget`_ to uncomment config in **_`.env`_** file if you prefer running in docker

#### Run

```
docker compose up -d
```

access : **_`http://localhost`_**  
database access : **_`localhost`_** port **_`3307`_**

---

### Demo

visit demo : ***https://rental-mobil.anri.my.id***

`admin`  
 email : *admin@gmail.com*  
 password : _admin123_

`client`  
 email : *client@gmail.com*  
 password : _client123_

---

#### Note

Aplikasi ini masih sangat banyak kekurangan.
Aplikasi ini dibuat untuk memenuhi tugas mata kuliah **_`Basis Data`_**
