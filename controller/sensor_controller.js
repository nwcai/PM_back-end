const db = require('../config/dbCon');
const {fetchAndSaveSensors} = require('../service/sensor_service');
const { fetchAndSaveSensorData } = require('../service/sensor_service');

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

        const { name, detail, note, warning_severity, critical_severity, id_sensor, id_machine, status_sensor, state, warning_vibration_x, warning_vibration_y, warning_vibration_z, warning_temp,
            critical_vibration_x, critical_vibration_y, critical_vibration_z, critical_temp } = req.body;


        // Validate required fields
        if (!name || !id_sensor) {
            console.error('Missing required fields:', req.body);
            return res.status(400).json({ error: 'Bad request: Missing required fields' });
        }


        // SQL query with parameterized placeholders
        const query = `
       INSERT INTO sensor(
           id_machine, name, status, id_sensor, create_by, create_date, status_sensor,state, detail, note,warning_severity,critical_severity,
           warning_vibration_x, warning_vibration_y, warning_vibration_z, warning_temp, 
           critical_vibration_x, critical_vibration_y, critical_vibration_z, critical_temp 
       ) 
       VALUES (?, ?, 'active', ?, 'admin', NOW(), ?,'good', ?,?, ?,?,
               ?, ?, ?, ?, ?, ?, ?, ?)
        `;

        // Execute query with parameters
        db.query(query, [id_machine, name, id_sensor, status_sensor || 1, state, detail, note, warning_severity, critical_severity,
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

        const { id_machine, id_sensor, name, detail, note, warning_severity, critical_severity, status, create_date, create_by, status_sensor, update_by, state,
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
                id_machine, name, status, id_sensor, create_by, create_date, update_by, update_date, status_sensor,state, detail, note,warning_severity,critical_severity,
                warning_vibration_x, warning_vibration_y, warning_vibration_z, warning_temp, 
                critical_vibration_x, critical_vibration_y, critical_vibration_z, critical_temp
            ) 
            VALUES (?, ?, 'active', ?, ?, NOW(), ?, NOW(), ?,?,?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                
                `;
            db.query(queryinsert, [id_machine, name, id_sensor, create_by, update_by, status_sensor, state, detail, note, warning_severity, critical_severity,
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



    GetAllSensorDataById: (req, res) => {
        const id = req.params.id_sensor; // Corrected extraction of id
        const query = `
        SELECT sd.vibration_x, sd.vibration_y, sd.vibration_z, sd.temp, sd.create_date
        FROM sensor_data sd
        JOIN sensor s ON sd.id_sensor = s.id_sensor
        JOIN status_senser ss ON ss.status_id = s.status_sensor
        WHERE s.status = 'active' AND s.id_sensor = ?;
        `;

        db.query(query, [id], (err, result) => {
            if (err) {
                console.error(err);
                return res.status(500).send('Server error');
            }
            res.json(result);
        });
    },

    InsertSensorData: (req, res) => {
        const { id_sensor, vibration_x, vibration_y, vibration_z, temp } = req.body;

        const query = `
          INSERT INTO sensor_data (id_sensor, vibration_x, vibration_y, vibration_z, temp, create_date)
          VALUES (?, ?, ?, ?, ?, NOW())
        `;

        db.query(query, [id_sensor, vibration_x, vibration_y, vibration_z, temp], (err, result) => {
            if (err) {
                console.error("Database error:", err);
                return res.status(500).json({ error: "Server error" });
            }
            CheckAndUpdateSensorState(id_sensor);
            res.status(201).json({ message: "Sensor data added successfully" });
        });
    },

    FetchAndSaveSensors: async (req, res) => {
        try {
            await fetchAndSaveSensors();
            res.status(200).send('Sensors fetched and saved successfully');
        } catch (error) {
            console.error('Error fetching and saving sensors:', error);
            res.status(500).send('Error fetching and saving sensors');
        }
    },

    FetchAndSaveSensorData: async (req, res) => {
        const { sensorId, start, end } = req.query;

        if (!sensorId || !start || !end) {
            return res.status(400).send('Missing required parameters: sensorId, start, or end');
        }

        try {
            await fetchAndSaveSensorData(sensorId, start, end);
            res.status(200).send('Sensor data fetched and saved successfully');
        } catch (error) {
            console.error('Error fetching and saving sensor data:', error);
            res.status(500).send('Error fetching and saving sensor data');
        }
    }
}

const CheckAndUpdateSensorState = (id_sensor) => {
    const queryCheck = `
        SELECT vibration_x, vibration_y, vibration_z, temp
        FROM sensor_data
        WHERE id_sensor = ?
        ORDER BY create_date DESC
        LIMIT 3
    `;

    db.query(queryCheck, [id_sensor], (err, rows) => {
        if (err) {
            console.error('Database error:', err);
            return;
        }

        if (rows.length === 3) {
            const queryThresholds = `
                SELECT warning_vibration_x, warning_vibration_y, warning_vibration_z, warning_temp,
                       critical_vibration_x, critical_vibration_y, critical_vibration_z, critical_temp,
                       state
                FROM sensor
                WHERE id_sensor = ?
            `;

            db.query(queryThresholds, [id_sensor], (err, thresholds) => {
                if (err) {
                    console.error('Database error:', err);
                    return;
                }

                if (thresholds.length === 0) {
                    console.error('No thresholds found for sensor:', id_sensor);
                    return;
                }

                const {
                    warning_vibration_x, warning_vibration_y, warning_vibration_z, warning_temp,
                    critical_vibration_x, critical_vibration_y, critical_vibration_z, critical_temp,
                    state: currentState // ดึงสถานะปัจจุบันของเซ็นเซอร์
                } = thresholds[0];

                let warningCount = 0;
                let criticalCount = 0;

                rows.forEach((row) => {
                    if (
                        row.vibration_x >= critical_vibration_x || row.vibration_y >= critical_vibration_y ||
                        row.vibration_z >= critical_vibration_z || row.temp >= critical_temp
                    ) {
                        criticalCount++;
                    } else if (
                        row.vibration_x >= warning_vibration_x || row.vibration_y >= warning_vibration_y ||
                        row.vibration_z >= warning_vibration_z || row.temp >= warning_temp
                    ) {
                        warningCount++;
                    }
                });

                let newState = currentState; // เริ่มต้นด้วยสถานะปัจจุบัน
                if (criticalCount === 3) {
                    newState = 'critical';
                } else if (warningCount === 3) {
                    newState = 'warning';
                } else if (criticalCount === 0 && warningCount === 0) {
                    // หากไม่มีข้อมูลที่ตรงกับเกณฑ์ critical หรือ warning
                    newState = 'good';
                }

                // อัปเดตสถานะเฉพาะเมื่อสถานะใหม่แตกต่างจากสถานะปัจจุบัน
                if (newState !== currentState) {
                    const queryUpdateState = `
                        UPDATE sensor
                        SET state = ?
                        WHERE status = 'active' AND id_sensor = ?
                    `;

                    db.query(queryUpdateState, [newState, id_sensor], (err, result) => {
                        if (err) {
                            console.error('Database error:', err);
                            return;
                        }
                        console.log(`Sensor state updated to ${newState} for sensor ID: ${id_sensor}`);
                    });
                }
            });
        }
    });
};


module.exports = {
    ...SensorController,
    CheckAndUpdateSensorState,
};