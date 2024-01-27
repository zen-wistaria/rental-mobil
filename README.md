# Installation

### Config database connection

rename env to .env  
example inside of .env

```
MYSQL_HOST=http://localhost
MYSQL_PORT=3306
MYSQL_DATABASE=rental-mobil
MYSQL_USER=user
MYSQL_PASSWORD=user
```

---

### Running on localhost

#### Requirement

- node 18^
- npm 10^

#### Run

```
npm i && npm start
```

> access **http://localhost:3000**

---

### Running on docker

#### Requirement

- docker
- docker-compose

#### Run

```
docker compose up -d
```

> access **http://localhost**
