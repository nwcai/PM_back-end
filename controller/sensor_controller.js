const db = require('../config/dbCon');

const SensorController = {
    GetAllSensor: (req, res) => {
        const query = `
        SELECT * FROM sensor WHERE status = 'active'
        `;

        db.query(query, (err, result) => {
            if (err) {
                console.error(err);
                return res.status(500).send('Server error');
            }
            res.json(result);
        });
    },
    GetSensorById: (req, res) => {
        const { id } = req.params
        const query = `
        SELECT * FROM sensor WHERE status = 'active' and id = ?
        `;

        db.query(query, [id], (err, result) => {
            if (err) {
                console.error(err);
                return res.status(500).send('Server error');
            }
            res.json(result);
        });
    },

    CreateSensor: (req, res) => {
        if (!req.body) {
            return res.status(400).json({ error: 'Request body is missing' });
        }

        const { id_sensor, name, detail, note, serial_number, status } = req.body;

        // Validate required fields
        if (!id_sensor || !name || !serial_number) {
            console.error('Missing required fields:', req.body);
            return res.status(400).json({ error: 'Bad request: Missing required fields' });
        }

        // SQL query with parameterized placeholders
        const query = `
       INSERT INTO sensor( id_senser, id_machine, name, status, serial_number, create_by, create_date, status_sensor, detail, note) 
       VALUES (?,?,?,'active',?,'admin',Now(),?,?,?)
        `;

        // Execute query with parameters
        db.query(query, [id_sensor, name, serial_number, status_sensor, detail, note], (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Server error' });
            }
            res.status(201).json({ message: 'sensor added successfully', userId: result.insertId });
        });
    },

    UpdateSensor: (req, res) => {
        if (!req.body) {
            return res.status(400).json({ error: 'Request body is missing' });
        }

        const { id_sensor, name, detail, note, serial_number, status, create_date, create_by } = req.body;
        if (!req.params) {
            return res.status(400).json({ error: 'Request body is missing' });
        }
        const { id } = req.params
        // SQL query Update
        const queryupdate = `
        UPDATE sensor SET status = ? WHERE id = ?
        `;
        // Execute query with parameters
        db.query(queryupdate, ['inactive', id], (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Server error' });
            }
            const queryinsert = `INSERT INTO sensor( id_senser, id_machine, name, status, serial_number, create_by, create_date, update_by, update_date, status_sensor, detail, note)
             VALUES (?,?,?,'active',?,?,?,'admit',Now(),?,?,?)
                
                `;
            db.query(queryinsert, [id_sensor, id_machine, name, serial_number, create_by, create_date, status_sensor, detail, note], (err, result) => {
                if (err) {
                    console.error('Database error:', err);
                    return res.status(500).json({ error: 'Server error' });
                }
                res.status(201).json({ message: 'machine added successfully', userId: result.insertId });
            });

        });

    },

    DeletesensorById: (req, res) => {
        if (!req.params) {
            return res.status(400).json({ error: 'Request body is missing' });
        }
        const { id } = req.params
        const query = `
        UPDATE sensor SET status = 'inactive' , update_date = Now() , update_by = 'Admin'
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

module.exports = SensorController;
