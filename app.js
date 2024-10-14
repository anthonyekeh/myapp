const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();

// Setup MySQL connection
const db = mysql.createConnection({
  host: '192.168.1.126',
  user: 'anthony',
  password: 'Huawei@1234##',
  database: 'formdb'
});

db.connect((err) => {
  if (err) {
    throw err;
  }
  console.log('MySQL Connected...');
});

// Middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, 'public')));

// Route to serve the form
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Route to handle form submission
app.post('/submit', (req, res) => {
  const { name, email, message } = req.body;

  const query = `INSERT INTO users (name, email, message) VALUES (?, ?, ?)`;
  
  db.query(query, [name, email, message], (err, result) => {
    if (err) {
      throw err;
    }
    console.log('Data inserted');
    
    // Redirect back to the form page after successful submission
    res.redirect('/');
  });
});


// Start server
const PORT = 3000;
app.listen(PORT,'0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});
