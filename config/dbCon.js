const mysql = require('mysql');

// Create a connection pool to MySQL
const db = mysql.createPool({
  user: 'root',
  host: 'localhost',
  password: '',
  database: 'predictive_maintenance',
});

module.exports = db; 