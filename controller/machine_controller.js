const db = require('../config/dbCon');

const MachineController = {
    GetAllMachines: (req, res) => {
        const query = `
        SELECT mac.*, s_m.status_name, COUNT(s.id_sensor) AS sensor_count
        FROM machine mac
        JOIN status_machine s_m ON s_m.status_id = mac.status_machine
        LEFT JOIN sensor s ON mac.id_machine = s.id_machine AND s.status = 'active'
        WHERE mac.status = 'active'
        GROUP BY mac.id_machine, s_m.status_name;
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
            console.error('Request body is missing');
            return res.status(400).json({ error: 'Request body is missing' });
        }
    
        const { id_machine, machine_name, detail, note, life_time } = req.body;
    
        // Log the received data
        console.log('Received data for CreateMachine:', req.body);
    
        // Validate required fields
        if (!id_machine || !machine_name) {
            console.error('Missing required fields:', req.body);
            return res.status(400).json({ error: 'Bad request: Missing required fields' });
        }
    
        // SQL query with parameterized placeholders
        const query = `
        INSERT INTO machine(id_machine, machine_name, detail, note, status, status_machine, create_date, create_by, life_time)
         VALUES (?,?,?,?,'active',?,NOW(),'Admin',?)
        `;
    
        // Execute query with parameters
        db.query(query, [id_machine, machine_name, detail, note, 1, life_time], (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Server error' });
            }
            console.log('Machine created successfully:', result);
            res.status(201).json({ message: 'machine added successfully', userId: result.insertId });
        });
    },

    UpdateMachine: (req, res) => {
        if (!req.body) {
            return res.status(400).json({ error: 'Request body is missing' });
        }

        const { id_machine, machine_name, detail, note, status, status_machine, create_date, create_by,life_time } = req.body;
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
                INSERT INTO machine(id_machine, machine_name, detail, note, status, status_machine, create_date, create_by, update_date, update_by, life_time) 
                VALUES (?,?,?,?,'active',?,?,?,NOW(),'Admin',?)
                `;
            db.query(queryinsert, [id_machine, machine_name, detail, note, status_machine, create_date, create_by, life_time], (err, result) => {
                if (err) {
                    console.error('Database error:', err);
                    return res.status(500).json({ error: 'Server error' });
                }
                res.status(201).json({ message: 'machine added successfully', userId: result.insertId });
            });

        });

    },

    GetAllNameMachine: (req, res) => {
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

    GetEventById: (req, res) => {
        if (!req.params || !req.params.id) {
            return res.status(400).json({ error: 'Missing required parameter: id' });
        }

        const { id } = req.params;

        const query = `
            SELECT *
            FROM event 
            WHERE id = ?

        `;

        db.query(query, [id], (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Server error' });
            }

            if (result.length === 0) {
                return res.status(404).json({ error: 'Event not found' });
            }

            res.status(200).json(result[0]);
        });
    },
    


    AddEvent: (req, res) => {
        if (!req.body) {
            return res.status(400).json({ error: 'Request body is missing' });
        }

        const { id_machine, event_name, event_type, severity, description, timestamp } = req.body;

        const query = `
            INSERT INTO event (id_machine,id_sensor,event_name, event_type, severity, description, timestamp)
            VALUES (?,"-",?, ?, ?, ?, NOW())
        `;
        console.log("Received Event Data:", req.body);
        db.query(query, [id_machine, event_name, event_type, severity, description, timestamp], (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Server error' });
            }
            res.status(201).json({ message: 'Event added successfully', eventId: result.insertId });
        });
    },




    GetEventsByMachineId: (req, res) => {
        const { id_machine } = req.params;

        const query = `
            SELECT * FROM event WHERE id_machine = ?;
        `;

        db.query(query, [id_machine], (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Server error' });
            }
            res.json(result);
        });
    },


    AddRepair: (req, res) => {
        if (!req.body) {
            return res.status(400).json({ error: 'Request body is missing' });
        }

        const { id, repair_date, repair_effectiveness, repair_detail } = req.body;

        const query = `
            UPDATE event
        SET repair_date = ?, repair_effectiveness = ?, repair_detail = ?
        WHERE id = ?
        `;
        console.log("Received Event Data:", req.body);
        db.query(query, [repair_date, repair_effectiveness, repair_detail, id], (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Server error' });
            }
            res.status(201).json({ message: 'Event added successfully', eventId: result.insertId });
        });
    },



    //***************************************************************************************************************************************
    CheckSensorState: (req, res) => {
        console.log('CheckSensorState called');
        const query = `
            SELECT id_sensor, state
            FROM sensor
            WHERE state IN ('warning', 'critical')
        `;
        db.query(query, (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Server error' });
            }
            console.log('Sensor state query result:', result);
            if (result.length === 0) {
                return res.status(404).json({ error: 'Sensor not found' });
            }
    
            // Process each sensor
            result.forEach((sensor) => {
                const { id_sensor, state: new_state } = sensor;
    
                // Get the latest sensor information and check repair effectiveness
                const queryGetSensorInfo = `
                    SELECT s.id_machine, s.name AS event_name, s.warning_severity, s.critical_severity, 
                           e.repair_effectiveness, e.severity AS current_severity, e.id AS event_id
                    FROM sensor s
                    LEFT JOIN event e ON s.id_machine = e.id_machine AND s.id_sensor = e.id_sensor
                    WHERE s.id_sensor = ?
                    ORDER BY e.timestamp DESC
                    LIMIT 1
                `;
                db.query(queryGetSensorInfo, [id_sensor], (err, sensorInfo) => {
                    if (err) {
                        console.error('Database error:', err);
                        return res.status(500).json({ error: 'Server error' });
                    }
    
                    if (sensorInfo.length === 0) {
                        return res.status(404).json({ error: 'Sensor not found' });
                    }
    
                    const { id_machine, event_name, warning_severity, critical_severity, repair_effectiveness, current_severity, event_id } = sensorInfo[0];
                    let severity = 0;
    
                    // Determine severity based on state
                    if (new_state === 'warning') {
                        severity = warning_severity;
                    } else if (new_state === 'critical') {
                        severity = critical_severity;
                    }
    
                    // Ensure severity is not downgraded if it is already critical
                    if (current_severity === critical_severity) {
                        severity = critical_severity;
                    }
    
                    // Check if the event already exists
                    const queryCheckEvent = `
                        SELECT id, repair_effectiveness
                        FROM event
                        WHERE id_machine = ? AND id_sensor = ? AND event_name = ? AND event_type = 'automatic'
                        ORDER BY timestamp DESC
                        LIMIT 1
                    `;
                    db.query(queryCheckEvent, [id_machine, id_sensor, event_name], (err, existingEvent) => {
                        if (err) {
                            console.error('Database error:', err);
                            return res.status(500).json({ error: 'Server error' });
                        }
    
                        const description = `Sensor state ${new_state === 'warning' ? 'changed to warning' : 'changed to critical'}`;
    
                        if (existingEvent.length === 0) {
                            // Add a new event if it doesn't exist
                            const queryInsertEvent = `
                                INSERT INTO event (id_machine, id_sensor, event_name, event_type, severity, description, timestamp)
                                VALUES (?, ?, ?, 'automatic', ?, ?, NOW())
                            `;
                            db.query(queryInsertEvent, [id_machine, id_sensor, event_name, severity, description], (err, result) => {
                                if (err) {
                                    console.error('Database error:', err);
                                    return res.status(500).json({ error: 'Server error' });
                                }
                                console.log(`New event added for sensor ID: ${id_sensor}`);
                            });
                        } else {
                            // Check repair_effectiveness
                            const { id: existingEventId, repair_effectiveness: existingRepairEffectiveness } = existingEvent[0];
    
                            if (existingRepairEffectiveness !== null) {
                                // Add a new event if repair_effectiveness is not NULL
                                const queryInsertEvent = `
                                    INSERT INTO event (id_machine, id_sensor, event_name, event_type, severity, description, timestamp)
                                    VALUES (?, ?, ?, 'automatic', ?, ?, NOW())
                                `;
                                db.query(queryInsertEvent, [id_machine, id_sensor, event_name, severity, description], (err, result) => {
                                    if (err) {
                                        console.error('Database error:', err);
                                        return res.status(500).json({ error: 'Server error' });
                                    }
                                    console.log(`New event added for sensor ID: ${id_sensor}`);
                                });
                            } else {
                                // Update the existing event if repair_effectiveness is NULL
                                const queryUpdateEvent = `
                                    UPDATE event
                                    SET severity = ?, description = ?
                                    WHERE id = ?
                                `;
                                db.query(queryUpdateEvent, [severity, description, existingEventId], (err, result) => {
                                    if (err) {
                                        console.error('Database error:', err);
                                        return res.status(500).json({ error: 'Server error' });
                                    }
                                    console.log(`Event updated for sensor ID: ${id_sensor}`);
                                });
                            }
                        }
                    });
                });
            });
    
            res.status(200).json({ message: 'Sensor state checked and events processed' });
        });
    },



}

module.exports = MachineController;
