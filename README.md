# sql-unit-test-template

## Purpose

JEST code and structure to deploy and directly unit test SQL objects that may not be directly exposed using an ORM tool.

The template contains a sample postgreSQL database schema and sample JEST code to setup, run and teardown the tests.

The sample database is postgreSQL, but another RDBMS can be substituted by modifying the database container and the connection string in the environment variable. Also, the entire database container may be removed and, with minimal modification, the structure in the test directory could be used to test a remote database.

See [Structure.md](Structure.md) for a description of the directory structure and sample files.

---

## Usage

### For Fully Containerized Testing

#### System Requirements

- Docker running on system
- Access to hub.docker.com to download the container images

#### Commands

- To start the testing process, run the shell script in the root directory of the project

  ```/bin/bash
  ./run_tests.sh
  ```

- This script rebuilds the containers and runs the tests. Rebuilding every time is not the most efficient, however, it insures that any changes to the database structure will be reflected in the database container.
- If you are only changing tests, you can run the run_tests.sh script with no_rebuild as the first argument and, provided you already have an image, it will use it. If you are in development and making changes to the database objects, see "For Local Testing and Development with a Container Database" next for a more efficient workflow.
- The run_tests.sh script accepts all regular JEST arguments and passes them to the command in the container, even if the no_rebuild argument is used as the first argument.

### For Local Testing and Development with a Container Database

#### System Requirements

- Docker running on system
- Access to hub.docker.com to download the container images
- Python, either installed globally or in a virual environment
- All python packages listed in requirements.txt installed in the environment
- Environment variable SQL_UNIT_TEST_TEMPLATE_DB_URL set

  ```/bin/bash
  export SQL_UNIT_TEST_TEMPLATE_DB_URL=postgresql://postgres:postgres@localhost:5432/postgres
  ```

- A postgres client to interact with the database
  - [pgAdmin4](https://www.pgadmin.org/) is a full featured GUI client
  - [psql](https://www.postgresql.org/docs/13/app-psql.html) is the CLI that comes with a postgreSQL database installation. If you do not have postgreSQL database on the machine (it's better to run it a container), read this to [install just the psql client on a MAC with homebrew](https://stackoverflow.com/questions/44654216/correct-way-to-install-psql-without-full-postgres-on-macos).
  - or your favorite postgreSQL client

#### Commands

- Start the container database from an image
  - If you have already run in Fully Containerized mode, you should already have a Docker image named: postgres_sql_test_db
  - If not, you will need to build an image for the test database
    ```/bin/bash
    docker build -t postgres_sql_test_db -f containers/db/Dockerfile .
    ```

  ```/bin/bash
  docker run -d --name <container-name> --publish 5432:5432 postgres_sql_test_db
  ```

- Load any test/development data necessary

- Run the tests
  - From the template root directory, run JEST

  ```/bin/bash
  JEST
  ```

- Modify the database objects and/or tests, rinse and repeat.

---

## Provided Examples and Test Data

- All test data is in .csv form. This allows the same data to be used by the JEST suite or be loaded directly into the database with the postgreSQL copy utility and used for development.

- test/data/author.csv
  - Two test rows for the author table.
- test/data/book.csv
  - Eight test rows for the book table.

- To load the data directly with psql
  - start the database container manually
  - log into psql

    ```/bin/bash
    psql -h localhost -U postgres  -p 5432
    ```

    - this will prompt you for the password, avoid this, set up a [password file](https://www.postgresql.org/docs/9.3/libpq-pgpass.html) in your home directory.

  - in the psql client, from the parent directory run

    ```/bin/bash
    \copy author FROM test/data/author.csv WITH CSV HEADER;
    \copy book FROM test/data/book.csv WITH CSV HEADER;
    ```

---

## Links

[Template Structure](Structure.md)

[JEST Documentation](https://docs.JEST.org/)

[psycopy2 Documentation](https://pypi.org/project/psycopg2/)

[psycopy2 Extras Documentation](https://www.psycopg.org/docs/extras.html)

[postgreSQL downloads and Documentation](https://www.postgresql.org/)

[pgAdmin download and Documentation](https://www.pgadmin.org/)

[psql client only for mac install instructions](https://stackoverflow.com/questions/44654216/correct-way-to-install-psql-without-full-postgres-on-macos)
