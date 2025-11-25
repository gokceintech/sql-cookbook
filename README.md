# SQL Cookbook & Playbook

> Production-minded SQL recipes with demo data and CI-tested queries for **PostgreSQL** and **MySQL**.

[![Lint](https://github.com/gokceintech/sql-cookbook/actions/workflows/lint-sql.yml/badge.svg)](../../actions)
[![Postgres Tests](https://github.com/gokceintech/sql-cookbook/actions/workflows/test-postgres.yml/badge.svg)](../../actions)
[![MySQL Tests](https://github.com/gokceintech/sql-cookbook/actions/workflows/test-mysql.yml/badge.svg)](../../actions)
[![Docs](https://img.shields.io/badge/docs-GitHub%20Pages-blue)](https://gokceintech.github.io/sql-cookbook/)

## Quick start
```bash
# clone and enter
git clone https://github.com/USERNAME/REPO.git
cd REPO

# (optional) set up pre-commit
pip install pre-commit sqlfluff
pre-commit install

# lint SQL locally
sqlfluff lint sql/postgres --dialect postgres
sqlfluff lint sql/mysql --dialect mysql
```

## What’s inside
- `sql/postgres` and `sql/mysql`: schemas, queries, and lightweight tests with sample data.
- CI:
  - **Lint** with [sqlfluff].
  - **Integration tests** on Postgres & MySQL via GitHub Actions service containers.
- **Docs** under `/docs` auto-published with GitHub Pages.
- Contributor guides & templates.

## Local testing (Docker)
```bash
# Start Postgres
docker run --rm -d --name pg -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=sqlexpert -p 5432:5432 postgres:16
psql "postgresql://postgres:postgres@localhost:5432/sqlexpert" -f sql/postgres/schema/ecommerce_schema.sql
psql "postgresql://postgres:postgres@localhost:5432/sqlexpert" -f sql/postgres/queries/top_customers.sql

# Start MySQL
docker run --rm -d --name mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=sqlexpert -p 3306:3306 mysql:8
mysql -h 127.0.0.1 -uroot -proot sqlexpert < sql/mysql/schema/ecommerce_schema.sql
mysql -h 127.0.0.1 -uroot -proot -N -B sqlexpert < sql/mysql/queries/top_customers.sql
```

## GitHub Pages
- In **Settings → Pages**, choose “Deploy from branch” and select `/docs` as the folder.

## Contributing
See [CONTRIBUTING.md](CONTRIBUTING.md).

## License
MIT — see [LICENSE](LICENSE).

---
**Replace `USERNAME` and `REPO` above with your GitHub username and repository name.**
