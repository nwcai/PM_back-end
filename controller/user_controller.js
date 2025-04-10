const db = require('../config/dbCon');
const bcrypt = require('bcrypt');
const jwt = require("jsonwebtoken");

const UserController = {
    GetAllUser: (req, res) => {
        const query = `
        SELECT u.* ,r.role_name , s.status_name
        FROM user u
        
        JOIN role r ON r.role_id = u.role_id
        JOIN status_user s ON s.id = u.status_user
        WHERE u.status = 'active'
        `;

        db.query(query, (err, result) => {
            if (err) {
                console.error(err);
                return res.status(500).send('Server error');
            }
            res.json(result);
        });
    },

    GetAllUserByID: (req, res) => {
        const { id } = req.params;
        const query = `
        SELECT u.* ,r.role_name , s.status_name
        FROM user u
        
        JOIN role r ON r.id = u.role_id
        JOIN status_user s ON s.id = u.status_user
        WHERE u.status = 'active' AND u.id =  ?`;

        db.query(query, [id] , (err, result) => {
            if (err) {
                console.error(err);
                return res.status(500).send('Server error');
            }
            res.json(result);
        });
    },

    CreateUser: async (req, res) => {
        if (!req.body) {
            return res.status(400).json({ error: 'Request body is missing' });
        }
    
        const { user_id, first_name, last_name, tel, email, role_id, password } = req.body;
    
        // Validate required fields
        if (!user_id || !first_name || !last_name || !tel || !email || !role_id || !password) {
            console.error('Missing required fields:', req.body);
            return res.status(400).json({ error: 'Bad request: Missing required fields' });
        }
    
        try {
            // Hash password
            const hashedPassword = await bcrypt.hash(password, 10);
    
            // SQL query with parameterized placeholders
            const query = `
            INSERT INTO user (user_id, username, first_name, last_name, role_id, tel, email, status, status_user, create_date, create_by, password) 
            VALUES (?, ?, ?, ?, ?, ?, ?, 'active', '1', NOW(), 'admin', ?)
            `;
    
            // Execute query with parameters
            db.query(query, [user_id, user_id, first_name, last_name, role_id, tel, email, hashedPassword], (err, result) => {
                if (err) {
                    console.error('Database error:', err);
                    return res.status(500).json({ error: 'Server error' });
                }
                res.status(201).json({ message: 'User added successfully', userId: result.insertId });
            });
        } catch (error) {
            console.error('Error hashing password:', error);
            return res.status(500).json({ error: 'Server error' });
        }
    },

    UpdateUser: (req, res) => {
        if (!req.body) {
            return res.status(400).json({ error: 'Request body is missing' });
        }
    
        const { id, user_id , username , first_name, last_name, tel, email, role_id,password } = req.body;
    
        // Validate required fields
        if (!user_id || !username || !first_name || !last_name || !tel || !email ||  !role_id) {
            console.error('Missing required fields:', req.body);
            return res.status(400).json({ error: 'Bad request: Missing required fields' });
        }

        const queryUpdate = `
        UPDATE user SET status ='inactive' WHERE id = ?
        `;
    
        // SQL query with parameterized placeholders
        const query = `
        INSERT INTO user (user_id, username, first_name, last_name,  role_id, tel, email, status, status_user, create_date, create_by,password) 
        VALUES (?, ?, ?,  ?, ?, ?, ?,'active' ,'1' , NOW(), 'admin',?)
        `;
    
        // Execute query with parameters
        db.query(queryUpdate,[id],(err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Server error' });
            }
            db.query(query, [user_id, username, first_name, last_name, role_id, tel, email,password], (err, result) => {
                if (err) {
                    console.error('Database error:', err);
                    return res.status(500).json({ error: 'Server error' });
                }
                res.status(201).json({ message: 'User added successfully', userId: result.insertId });
            });
        });
    },

    Login : async (req, res) => {
        if (!req.body) {
            return res.status(400).json({ error: "Request body is missing" });
        }
    
        const { username, password } = req.body;
    
        // Validate required fields
        if (!username || !password) {
            return res.status(400).json({ error: "Username and password are required" });
        }
    
        try {
            // Retrieve user from the database
            const query = "SELECT * FROM user WHERE username = ? AND status = 'active'";
            db.query(query, [username], async (err, results) => {
                if (err) {
                    console.error("Database error:", err);
                    return res.status(500).json({ error: "Server error" });
                }
    
                if (results.length === 0) {
                    return res.status(401).json({ error: "Invalid username or password" });
                }
    
                const user = results[0];
    
                // Compare provided password with the stored hashed password
                const isMatch = await bcrypt.compare(password, user.password);
                if (!isMatch) {
                    return res.status(401).json({ error: "Invalid username or password" });
                }
    
                // Generate JWT token
                const token = jwt.sign(
                    { user_id: user.user_id, username: user.username, role_id: user.role_id },
                    "KU79ENDTHISPROJECTPLASE", // Use environment variables for security
                    { expiresIn: "1h" }
                );
    
                res.status(200).json({ message: "Login successful", token, role_id: user.role_id});
            });
        } catch (error) {
            console.error("Error during login:", error);
            return res.status(500).json({ error: "Server error" });
        }
    },
}

module.exports = UserController;