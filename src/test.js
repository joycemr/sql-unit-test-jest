const { Client } = require('pg');

const db_url = {
    user: 'postgres',
    host: 'localhost',
    database: 'postgres',
    password: 'postgres',
    port: 5433,
}

const client = new Client(db_url);

client.connect();

let stmt = 'SELECT current_database()';

// get the database name
client.query(stmt, (err, res) => {
    if (err) {
        console.error(err);
        return;
    }
    for (let row of res.rows) {
        console.log(row);
    }
});

stmt = 'select version()'

// get the version
client.query(stmt, (err, res) => {
    if (err) {
        console.error(err);
        return;
    }
    for (let row of res.rows) {
        console.log(row);
    }
    client.end()
});

