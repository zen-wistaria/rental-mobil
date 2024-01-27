# Installation

### Config database connection

- rename **env** to **.env**

_example inside of_ **.env** :

```
MYSQL_HOST=http://localhost
MYSQL_PORT=3306
MYSQL_DATABASE=rental-mobil
MYSQL_USER=user
MYSQL_PASSWORD=user
```

---

### Running on localhost

#### Requirements

- node 18^
- npm 10^

#### Run

```
npm i && npm start
```

> access : **http://<i></i>localhost:3000**

---

### Running on docker

#### Requirements

- docker
- docker-compose

#### Config

change value of **MYSQL_HOST** in **.env** to **rental_mobil_db**  
_example :_

```
MYSQL_HOST=rental_mobil_db
MYSQL_PORT=3306
MYSQL_DATABASE=rental-mobil
MYSQL_USER=user
MYSQL_PASSWORD=user
```

#### Run

```
docker compose up -d
```

> access : **http://<i></i>localhost**  
> database access : **localhost** port **3307**
