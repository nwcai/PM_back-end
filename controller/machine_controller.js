const db = require('../config/dbCon');

const MachineController = {
    GetAllMachines: (req, res) => {
        const query = `
        SELECT mac.*,s_m.status_name FROM machine mac
        JOIN status_machine s_m ON s_m.status_id = mac.status_machine
        WHERE mac.status = 'active'
        `;

        db.query(query, (err, result) => {
            if (err) {
                console.error(err);
                return res.status(500).send('Server error');
            }
            res.json(result);
        });
    },

    GetMachineByID: (req, res) => {
        const { id } = req.params;
        const query = `
        SELECT m.*, t.machine_type, s.status_name
        FROM machine m
        JOIN machine_type t ON t.id = m.machine_type_id
        JOIN status_machine s ON s.id = m.status_machine
        WHERE m.status = 'active' AND m.id =  ?`;

        db.query(query, [id], (err, result) => {
            if (err) {
                console.error(err);
                return res.status(500).send('Server error');
            }
            res.json(result);
        });
    },

    CreateMachine: (req, res) => {
        if (!req.body) {
            return res.status(400).json({ error: 'Request body is missing' });
        }

        const { machine_id, name, detail, note, status } = req.body;

        // Validate required fields
        if (!machine_id || !name) {
            console.error('Missing required fields:', req.body);
            return res.status(400).json({ error: 'Bad request: Missing required fields' });
        }

        // SQL query with parameterized placeholders
        const query = `
        INSERT INTO machine(id_machine, machine_name, detail, note, status, status_machine, create_date, create_by) VALUES (?,?,?,?,'active',?,NOW(),'Admin')
        `;

        // Execute query with parameters
        db.query(query, [machine_id, name, detail, note, 1], (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Server error' });
            }
            res.status(201).json({ message: 'User added successfully', userId: result.insertId });
        });
    },

    UpdateMachine: (req, res) => {
        if (!req.body) {
            return res.status(400).json({ error: 'Request body is missing' });
        }

        const { id, machine_id, name, machine_type_id, status_machine } = req.body;

        // Validate required fields
        if (!machine_id || !name || !machine_type_id || !status_machine) {
            console.error('Missing required fields:', req.body);
            return res.status(400).json({ error: 'Bad request: Missing required fields' });
        }

        const queryUpdate = `
        UPDATE machine SET status = 'inactive' WHERE id = ?
        `;

        // SQL query with parameterized placeholders
        const query = `
        INSERT INTO machine (machine_id, name, machine_type_id, status_machine, status, create_date, create_by) 
        VALUES (?, ?, ?, ?, 'active', NOW(), 'admin')
        `;

        // Execute query with parameters
        db.query(queryUpdate, [id], (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Server error' });
            }
            db.query(query, [machine_id, name, machine_type_id, status_machine], (err, result) => {
                if (err) {
                    console.error('Database error:', err);
                    return res.status(500).json({ error: 'Server error' });
                }
                res.status(201).json({ message: 'Machine added successfully', machineId: result.insertId });
            });
        });
    },
}

module.exports = MachineController;
