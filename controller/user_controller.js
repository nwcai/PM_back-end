const db = require('../config/dbCon');

const UserController = {
    GetAllUser: (req, res) => {
        const query = `
        SELECT u.* ,r.role_name , s.status_name
        FROM user u
        
        JOIN role r ON r.id = u.role_id
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

    CreateUser: (req, res) => {
        if (!req.body) {
            return res.status(400).json({ error: 'Request body is missing' });
        }
    
        const { user_id, first_name, last_name, tel, email, role_id } = req.body;
    
        // Validate required fields
        if (!user_id || !first_name || !last_name || !tel || !email ||  !role_id) {
            console.error('Missing required fields:', req.body);
            return res.status(400).json({ error: 'Bad request: Missing required fields' });
        }
    
        // SQL query with parameterized placeholders
        const query = `
        INSERT INTO user (user_id, username, first_name, last_name, role_id, tel, email, status, status_user, create_date, create_by) 
        VALUES (?, ?, ?, ?, ?, ?, ?,'active' ,'1' , NOW(), 'admin')
        `;
    
        // Execute query with parameters
        db.query(query, [user_id, user_id, first_name, last_name, role_id, tel, email], (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Server error' });
            }
            res.status(201).json({ message: 'User added successfully', userId: result.insertId });
        });
    },

    UpdateUser: (req, res) => {
        if (!req.body) {
            return res.status(400).json({ error: 'Request body is missing' });
        }
    
        const { id, user_id , username , first_name, last_name, tel, email, role_id } = req.body;
    
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
        INSERT INTO user (user_id, username, first_name, last_name,  role_id, tel, email, status, status_user, create_date, create_by) 
        VALUES (?, ?, ?,  ?, ?, ?, ?,'active' ,'1' , NOW(), 'admin')
        `;
    
        // Execute query with parameters
        db.query(queryUpdate,[id],(err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Server error' });
            }
            db.query(query, [user_id, username, first_name, last_name, role_id, tel, email], (err, result) => {
                if (err) {
                    console.error('Database error:', err);
                    return res.status(500).json({ error: 'Server error' });
                }
                res.status(201).json({ message: 'User added successfully', userId: result.insertId });
            });
        });
    },
}

module.exports = UserController;