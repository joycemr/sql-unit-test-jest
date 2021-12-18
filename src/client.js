const { Client } = require('pg');

const db_url = {
    user: 'postgres',
    host: 'localhost',
    database: 'midb',
    password: 'postgres',
    port: 5435,
}

const client = new Client(db_url);

client.connect();

const stmt = 'SELECT * FROM support.trait';

// inspect all the data
client.query(stmt, (err, res) => {
    if (err) {
        console.error(err);
        return;
    }
    for (let row of res.rows) {
        console.log(row);
    }
});

// just look at the fields returned
client.query(stmt, (err, res) => {
    for (let field of res.fields) {
        console.log(field.name);
    }
    // Why does this have to be here?
    client.end()
});
