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

    GetMachinesById: (req, res) => {
        if (!req.params) {
            return res.status(400).json({ error: 'Request body is missing' });
        }
        const { id } = req.params
        const query = `
        SELECT mac.*,s_m.status_name FROM machine mac
        JOIN status_machine s_m ON s_m.status_id = mac.status_machine
        WHERE mac.status = 'active' and mac.id = ?
        limit 1
        `;

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

        const { id_machine, machine_name, detail, note } = req.body;

        // Validate required fields
        if (!id_machine || !machine_name) {
            console.error('Missing required fields:', req.body);
            return res.status(400).json({ error: 'Bad request: Missing required fields' });
        }

        // SQL query with parameterized placeholders
        const query = `
        INSERT INTO machine(id_machine, machine_name, detail, note, status, status_machine, create_date, create_by) VALUES (?,?,?,?,'active',?,NOW(),'Admin')
        `;

        // Execute query with parameters
        db.query(query, [id_machine, machine_name, detail, note, 1], (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Server error' });
            }
            res.status(201).json({ message: 'machine added successfully', userId: result.insertId });
        });
    },

    UpdateMachine: (req, res) => {
        if (!req.body) {
            return res.status(400).json({ error: 'Request body is missing' });
        }

        const { id_machine, machine_name, detail, note, status, status_machine, create_date, create_by} = req.body;
        if (!req.params) {
            return res.status(400).json({ error: 'Request body is missing' });
        }
        const { id } = req.params
        // SQL query Update
        const queryupdate = `
        UPDATE machine SET status = ? WHERE id = ?
        `;
        // Execute query with parameters
        db.query(queryupdate, ['inactive', id], (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Server error' });
            }
            const queryinsert = `
                INSERT INTO machine(id_machine, machine_name, detail, note, status, status_machine, create_date, create_by, update_date, update_by) 
                VALUES (?,?,?,?,'active',?,?,?,NOW(),'Admin')
                `;
                db.query(queryinsert, [id_machine, machine_name, detail, note, status_machine, create_date, create_by], (err, result) => {
                    if (err) {
                        console.error('Database error:', err);
                        return res.status(500).json({ error: 'Server error' });
                    }
                    res.status(201).json({ message: 'machine added successfully', userId: result.insertId });
                });

        });

    },

    GetAllNameMachine: (req,res) =>{
        const query = `
            SELECT id_machine, machine_name FROM machine WHERE status = 'active'
        `;

        db.query(query, (err, result) => {
            if (err) {
                console.error(err);
                return res.status(500).send('Server error');
            }
            res.json(result);
        });
    }, 

    DeleteMachinesById: (req, res) => {
        if (!req.params) {
            return res.status(400).json({ error: 'Request body is missing' });
        }
        const { id } = req.params
        const query = `
        UPDATE machine SET status = 'inactive' , update_date = Now() , update_by = 'Admin'
        WHERE id = ?
        `;

        db.query(query, [id], (err, result) => {
            if (err) {
                console.error(err);
                return res.status(500).send('Server error');
            }
            res.json(result);
        });
    },


}

module.exports = MachineController;
