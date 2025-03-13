const db = require('../config/dbCon');

const SensorController = {
    GetAllSensor: (req, res) => {
        const id = req.params.id_machine
        const query = `
        SELECT s.* , ss.status_name
        FROM sensor s
        JOIN status_senser ss ON ss.status_id = s.status_sensor
        WHERE s.status = 'active' AND s.id_machine = ? ;
        `;

        db.query(query, [id], (err, result) => {
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

        const { name, detail, note, serial_number, id_machine, status_sensor, warning_vibration_x, warning_vibration_y, warning_vibration_z, warning_temp, 
            critical_vibration_x, critical_vibration_y, critical_vibration_z, critical_temp } = req.body;

        
        // Validate required fields
        if (!name || !serial_number) {
            console.error('Missing required fields:', req.body);
            return res.status(400).json({ error: 'Bad request: Missing required fields' });
        }
        

        // SQL query with parameterized placeholders
        const query = `
       INSERT INTO sensor(
           id_machine, name, status, serial_number, create_by, create_date, status_sensor, detail, note,
           warning_vibration_x, warning_vibration_y, warning_vibration_z, warning_temp, 
           critical_vibration_x, critical_vibration_y, critical_vibration_z, critical_temp
       ) 
       VALUES (?, ?, 'active', ?, 'admin', NOW(), ?, ?, ?,
               ?, ?, ?, ?, ?, ?, ?, ?)
        `;

        // Execute query with parameters
        db.query(query, [ id_machine, name, serial_number, status_sensor || 1, detail, note,
            warning_vibration_x, warning_vibration_y, warning_vibration_z, warning_temp,
            critical_vibration_x, critical_vibration_y, critical_vibration_z, critical_temp], (err, result) => {
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

        const { id_machine, id_sensor, name, detail, note, serial_number, status, create_date, create_by, status_sensor, update_by,
            warning_vibration_x, warning_vibration_y, warning_vibration_z, warning_temp,
                critical_vibration_x, critical_vibration_y, critical_vibration_z, critical_temp
         } = req.body;
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
            const queryinsert = ` INSERT INTO sensor(
                id_machine, name, status, serial_number, create_by, create_date, update_by, update_date, status_sensor, detail, note,
                warning_vibration_x, warning_vibration_y, warning_vibration_z, warning_temp, 
                critical_vibration_x, critical_vibration_y, critical_vibration_z, critical_temp
            ) 
            VALUES (?, ?, 'active', ?, ?, NOW(), ?, NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                
                `;
            db.query(queryinsert, [id_machine, name, serial_number, create_by, update_by, status_sensor, detail, note,
                warning_vibration_x, warning_vibration_y, warning_vibration_z, warning_temp,
                critical_vibration_x, critical_vibration_y, critical_vibration_z, critical_temp], (err, result) => {
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
