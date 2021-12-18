const { Pool } = require('pg');

const db_url = {
    user: 'postgres',
    host: 'localhost',
    database: 'midb',
    password: 'postgres',
    port: 5435,
}

const stmt = 'SELECT * FROM support.trait';

const pool = new Pool(db_url);

pool.query(stmt, (err, res) => {
    for (let row of res.rows) {
        console.log(row);
    }
    pool.end()
});

