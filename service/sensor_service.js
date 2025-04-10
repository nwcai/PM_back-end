const axios = require('axios');
const db = require('../config/dbCon'); // เชื่อมต่อฐานข้อมูล

const BASE_Korawit_URL = "http://Korawit.ddns.net:6060";

const fetchAndSaveSensors = async () => {
    try {
        const response = await axios.get(`${BASE_Korawit_URL}/sensors`, {
            headers: {
                "Api-Key": "6e9caa8a-503a-4602-b577-84f2f0c776bd"
            }
        });

        // ตรวจสอบโครงสร้างของ response.data
        console.log('Response data:', response.data);

        // เข้าถึงฟิลด์ results
        const sensors = Array.isArray(response.data.results) ? response.data.results : [];

        if (sensors.length === 0) {
            console.log('No sensors found in the API response.');
            return;
        }

        sensors.forEach(sensor => {
            // เพิ่มเงื่อนไขการสุ่มค่า
            sensor.warning_x = sensor.warning_x ?? [0.5, 0.6][Math.floor(Math.random() * 2)];
            sensor.warning_y = sensor.warning_y ?? [0.5, 0.6][Math.floor(Math.random() * 2)];
            sensor.warning_z = sensor.warning_z ?? [0.5, 0.6][Math.floor(Math.random() * 2)];
            sensor.warning_temp = sensor.warning_temp ?? Math.floor(Math.random() * (60 - 40 + 1)) + 40;

            // ตรวจสอบค่าก่อนสุ่ม critical_x, critical_y, critical_z
            sensor.critical_x = sensor.critical_x ?? (sensor.warning_x ? sensor.warning_x + [0.2, 0.3,0.4][Math.floor(Math.random() * 3)] : 0.0);
            sensor.critical_y = sensor.critical_y ?? (sensor.warning_y ? sensor.warning_y + [0.2, 0.3,0.4][Math.floor(Math.random() * 3)] : 0.0);
            sensor.critical_z = sensor.critical_z ?? (sensor.warning_z ? sensor.warning_z + [0.2, 0.3,0.4][Math.floor(Math.random() * 3)] : 0.0);
            sensor.critical_temp = sensor.critical_temp ?? (sensor.warning_temp ? sensor.warning_temp + [10, 20, 30, 40][Math.floor(Math.random() * 4)] : 0.0);

            sensor.warning_severity = Math.floor(Math.random() * 5) + 1; // สุ่มค่า 1-5
            sensor.critical_severity = sensor.warning_severity + Math.floor(Math.random() * 3) + 1; // สุ่มบวกค่า 1-3 จาก warning_severity

            const mappedSensor = {
                id_machine: sensor.sensors_machine_id || null,
                id_sensor: sensor.sensor_id || null,
                name: sensor.name || null,
                status: 'active',
                create_by: 'admin',
                create_date: sensor.date_added,
                status_sensor: 1,
                state: 'good',
                warning_vibration_x: sensor.warning_x,
                warning_vibration_y: sensor.warning_y,
                warning_vibration_z: sensor.warning_z,
                warning_temp: sensor.warning_temp,
                critical_vibration_x: sensor.critical_x,
                critical_vibration_y: sensor.critical_y,
                critical_vibration_z: sensor.critical_z,
                critical_temp: sensor.critical_temp,
                warning_severity: sensor.warning_severity,
                critical_severity: sensor.critical_severity
            };

            const queryCheck = `SELECT id_sensor FROM sensor WHERE id_sensor = ?`;
            db.query(queryCheck, [mappedSensor.id_sensor], (err, result) => {
                if (err) {
                    console.error('Database error:', err);
                    return;
                }

                if (result.length === 0) {
                    const queryInsert = `
                        INSERT INTO sensor (
                            id_machine, id_sensor, name, status, create_by, create_date, status_sensor, state,
                            warning_vibration_x, warning_vibration_y, warning_vibration_z, warning_temp,
                            critical_vibration_x, critical_vibration_y, critical_vibration_z, critical_temp,
                            warning_severity, critical_severity
                        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    `;

                    const values = [
                        mappedSensor.id_machine,
                        mappedSensor.id_sensor,
                        mappedSensor.name,
                        mappedSensor.status,
                        mappedSensor.create_by,
                        mappedSensor.create_date,
                        mappedSensor.status_sensor,
                        mappedSensor.state,
                        mappedSensor.warning_vibration_x,
                        mappedSensor.warning_vibration_y,
                        mappedSensor.warning_vibration_z,
                        mappedSensor.warning_temp,
                        mappedSensor.critical_vibration_x,
                        mappedSensor.critical_vibration_y,
                        mappedSensor.critical_vibration_z,
                        mappedSensor.critical_temp,
                        mappedSensor.warning_severity,
                        mappedSensor.critical_severity
                    ];

                    db.query(queryInsert, values, (err, result) => {
                        if (err) {
                            console.error('Error inserting sensor:', err);
                        } else {
                            console.log('Sensor inserted successfully:', result.insertId);
                        }
                    });
                } else {
                    console.log(`Sensor with ID ${mappedSensor.id_sensor} already exists. Skipping insert.`);
                }
            });
        });
    } catch (error) {
        console.error('Error fetching sensors from API:', error);
    }
};

// ตัวนับสำหรับการตรวจสอบ state (ย้ายออกมานอกลูป)
let globalCriticalCount = 0;
let globalWarningCount = 0;
let lastWarningEventTriggered = false; // Track if the last warning event was triggered
let lastCriticalEventTriggered = false; // Track if the last critical event was triggered

const fetchAndSaveSensorData = async (sensorIds, start, end) => {
    try {
        for (const sensorId of sensorIds) {
            console.log(`Fetching data for sensor ID: ${sensorId}`);

            // ดึงข้อมูลจาก API สำหรับ sensorId ปัจจุบัน
            const response = await axios.get(`${BASE_Korawit_URL}/sensor_data/${sensorId}`, {
                params: {
                    start: start,
                    end: end
                },
                headers: {
                    "Api-Key": "6e9caa8a-503a-4602-b577-84f2f0c776bd"
                }
            });

            const sensorDataArray = Array.isArray(response.data) ? response.data : [];

            if (sensorDataArray.length === 0) {
                console.log(`No sensor data found for sensor ID ${sensorId}.`);
                continue;
            }

            for (const sensorData of sensorDataArray) {
                const mappedSensorData = {
                    id_sensor: sensorData.sensor_id || null,
                    create_date: sensorData.sensor_time || null,
                    repair_date: null, // ค่าเริ่มต้นเป็น NULL
                    vibration_x: sensorData.x || 0.0,
                    vibration_y: sensorData.y || 0.0,
                    vibration_z: sensorData.z || 0.0,
                    temp: sensorData.temp || 0.0
                };

                // ตรวจสอบว่าข้อมูลนี้มีอยู่ในฐานข้อมูลแล้วหรือไม่
                const queryCheck = `
                    SELECT id FROM sensor_data
                    WHERE id_sensor = ? AND create_date = ?
                `;
                const exists = await new Promise((resolve, reject) => {
                    db.query(queryCheck, [mappedSensorData.id_sensor, mappedSensorData.create_date], (err, result) => {
                        if (err) {
                            console.error('Error checking existing sensor data:', err);
                            reject(err);
                        } else {
                            resolve(result.length > 0);
                        }
                    });
                });

                if (exists) {
                    console.log(`Sensor data for ID ${mappedSensorData.id_sensor} at ${mappedSensorData.create_date} already exists. Skipping.`);
                    continue;
                }

                // เพิ่มข้อมูลลงใน sensor_data
                const queryInsert = `
                    INSERT INTO sensor_data (
                        id_sensor, create_date, repair_date, vibration_x, vibration_y, vibration_z, temp
                    ) VALUES (?, ?, ?, ?, ?, ?, ?)
                `;
                const values = [
                    mappedSensorData.id_sensor,
                    mappedSensorData.create_date,
                    mappedSensorData.repair_date,
                    mappedSensorData.vibration_x,
                    mappedSensorData.vibration_y,
                    mappedSensorData.vibration_z,
                    mappedSensorData.temp
                ];

                await new Promise((resolve, reject) => {
                    db.query(queryInsert, values, (err, result) => {
                        if (err) {
                            console.error('Error inserting sensor data:', err);
                            reject(err);
                        } else {
                            console.log('Sensor data inserted successfully:', result.insertId);
                            resolve(result);
                        }
                    });
                });

                // ตรวจสอบ state ของ sensor
                const querySensor = `SELECT * FROM sensor WHERE id_sensor = ?`;
                const sensor = await new Promise((resolve, reject) => {
                    db.query(querySensor, [sensorId], (err, result) => {
                        if (err) {
                            console.error('Error fetching sensor:', err);
                            reject(err);
                        } else {
                            resolve(result[0]);
                        }
                    });
                });

                if (!sensor) {
                    console.error(`Sensor with ID ${sensorId} not found.`);
                    continue;
                }

                // ตรวจสอบค่าที่เกิน warning และ critical
                const isWarning =
                    mappedSensorData.vibration_x > sensor.warning_vibration_x ||
                    mappedSensorData.vibration_y > sensor.warning_vibration_y ||
                    mappedSensorData.vibration_z > sensor.warning_vibration_z ||
                    mappedSensorData.temp > sensor.warning_temp;

                const isCritical =
                    mappedSensorData.vibration_x > sensor.critical_vibration_x ||
                    mappedSensorData.vibration_y > sensor.critical_vibration_y ||
                    mappedSensorData.vibration_z > sensor.critical_vibration_z ||
                    mappedSensorData.temp > sensor.critical_temp;

                console.log(`Sensor ID: ${sensorId}`);
                console.log(`Mapped Sensor Data:`, mappedSensorData);
                console.log(`Sensor Thresholds:`, {
                    warning_vibration_x: sensor.warning_vibration_x,
                    warning_vibration_y: sensor.warning_vibration_y,
                    warning_vibration_z: sensor.warning_vibration_z,
                    warning_temp: sensor.warning_temp,
                    critical_vibration_x: sensor.critical_vibration_x,
                    critical_vibration_y: sensor.critical_vibration_y,
                    critical_vibration_z: sensor.critical_vibration_z,
                    critical_temp: sensor.critical_temp
                });
                console.log(`Critical Count: ${globalCriticalCount}, Warning Count: ${globalWarningCount}`);
                console.log(`isCritical: ${isCritical}, isWarning: ${isWarning}`);

                if (isCritical) {
                    globalCriticalCount++;
                    globalWarningCount++;
                    console.log(`Critical Count: ${globalCriticalCount}, Warning Count: ${globalWarningCount}`);
                    console.log(`Sensor ID ${sensorId} is in critical state.`);

                    if (globalCriticalCount >= 3 && !lastCriticalEventTriggered) {
                        console.log(`Updating state to critical for Sensor ID: ${sensorId}`);
                        await updateSensorState(sensorId, 'critical', sensor.critical_severity, mappedSensorData.create_date);
                        lastCriticalEventTriggered = true; // Mark that a critical event was triggered
                    }
                } else if (isWarning) {
                    globalWarningCount++;
                    globalCriticalCount = 0; // Reset critical count
                    console.log(`Critical Count: ${globalCriticalCount}, Warning Count: ${globalWarningCount}`);

                    if (globalWarningCount >= 3 && !lastWarningEventTriggered) {
                        console.log(`Updating state to warning for Sensor ID: ${sensorId}`);
                        await updateSensorState(sensorId, 'warning', sensor.warning_severity, mappedSensorData.create_date);
                        lastWarningEventTriggered = true; // Mark that a warning event was triggered
                    }
                } else {
                    // Reset counts and event triggers when no conditions are met
                    if (globalCriticalCount > 0 || globalWarningCount > 0) {
                        console.log(`Resetting counts. Critical Count: ${globalCriticalCount}, Warning Count: ${globalWarningCount}`);
                    }
                    globalWarningCount = 0;
                    globalCriticalCount = 0;
                    lastWarningEventTriggered = false; // Reset warning event trigger
                    lastCriticalEventTriggered = false; // Reset critical event trigger
                }
            }
        }
    } catch (error) {
        console.error('Error fetching sensor data from API:', error);
    }
};

// ฟังก์ชันสำหรับเปลี่ยน state ของ sensor และเพิ่ม event
const updateSensorState = async (sensorId, newState, severity, timestamp) => {
    try {
        // อัปเดต state ของ sensor
        const queryUpdate = `UPDATE sensor SET state = ? WHERE id_sensor = ?`;
        await new Promise((resolve, reject) => {
            db.query(queryUpdate, [newState, sensorId], (err, result) => {
                if (err) {
                    console.error('Error updating sensor state:', err);
                    reject(err);
                } else {
                    console.log(`Sensor state updated to ${newState} for sensor ID ${sensorId}`);
                    resolve(result);
                }
            });
        });

        // ตรวจสอบว่ามี event ซ้ำหรือไม่
        const queryCheckEvent = `
            SELECT id, repair_date FROM event
            WHERE id_sensor = ?
            ORDER BY timestamp DESC LIMIT 1
        `;
        const eventName = `Sensor state changed to ${newState}`;
        const description = `The sensor state was updated to ${newState} with severity level ${severity}.`;

        const existingEvent = await new Promise((resolve, reject) => {
            db.query(queryCheckEvent, [sensorId], (err, result) => {
                if (err) {
                    console.error('Error checking existing event:', err);
                    reject(err);
                } else {
                    resolve(result[0] || null); // ถ้ามี event อยู่แล้วจะคืนค่า event object
                }
            });
        });

        if (existingEvent) {
            // ตรวจสอบว่า repair_date ไม่เป็น NULL
            if (existingEvent.repair_date !== null) {
                // ถ้ามีการซ่อมแซมแล้ว ให้เพิ่ม event ใหม่
                const queryInsertEvent = `
                    INSERT INTO event (
                        id_machine, id_sensor, event_name, event_type, severity, description, timestamp
                    ) VALUES (?, ?, ?, ?, ?, ?, ?)
                `;
                const eventType = 'automatic'; // กำหนดเป็น 'automatic' เนื่องจากเกิดจากระบบ

                const idMachine = await new Promise((resolve, reject) => {
                    const queryGetMachine = `SELECT id_machine FROM sensor WHERE id_sensor = ?`;
                    db.query(queryGetMachine, [sensorId], (err, result) => {
                        if (err) {
                            console.error('Error fetching id_machine for sensor:', err);
                            reject(err);
                        } else {
                            resolve(result[0]?.id_machine || null);
                        }
                    });
                });

                if (!idMachine) {
                    console.error(`id_machine not found for sensor ID ${sensorId}`);
                    return;
                }

                await new Promise((resolve, reject) => {
                    db.query(queryInsertEvent, [idMachine, sensorId, eventName, eventType, severity, description, timestamp], (err, result) => {
                        if (err) {
                            console.error('Error inserting event:', err);
                            reject(err);
                        } else {
                            console.log('Event inserted successfully:', result.insertId);
                            resolve(result);
                        }
                    });
                });
            } else {
                console.log(`Cannot insert new event for sensor ID ${sensorId} because repair_date is NULL.`);
            }
        } else {
            // ถ้าไม่มี event ให้ทำการ insert
            const queryGetMachine = `SELECT id_machine FROM sensor WHERE id_sensor = ?`;
            const idMachine = await new Promise((resolve, reject) => {
                db.query(queryGetMachine, [sensorId], (err, result) => {
                    if (err) {
                        console.error('Error fetching id_machine for sensor:', err);
                        reject(err);
                    } else {
                        resolve(result[0]?.id_machine || null);
                    }
                });
            });

            if (!idMachine) {
                console.error(`id_machine not found for sensor ID ${sensorId}`);
                return;
            }

            const queryInsertEvent = `
                INSERT INTO event (
                    id_machine, id_sensor, event_name, event_type, severity, description, timestamp
                ) VALUES (?, ?, ?, ?, ?, ?, ?)
            `;
            const eventType = 'automatic'; // กำหนดเป็น 'automatic' เนื่องจากเกิดจากระบบ

            await new Promise((resolve, reject) => {
                db.query(queryInsertEvent, [idMachine, sensorId, eventName, eventType, severity, description, timestamp], (err, result) => {
                    if (err) {
                        console.error('Error inserting event:', err);
                        reject(err);
                    } else {
                        console.log('Event inserted successfully:', result.insertId);
                        resolve(result);
                    }
                });
            });
        }
    } catch (error) {
        console.error('Error updating sensor state or inserting/updating event:', error);
    }
};

const checkRepair = async () => {
    try {
        // ดึงรายการ sensor ทั้งหมด
        const queryGetSensors = `SELECT id_sensor FROM sensor`;
        const sensors = await new Promise((resolve, reject) => {
            db.query(queryGetSensors, (err, result) => {
                if (err) {
                    console.error('Error fetching sensors:', err);
                    reject(err);
                } else {
                    resolve(result);
                }
            });
        });

        for (const sensor of sensors) {
            const sensorId = sensor.id_sensor;

            // ตรวจสอบ repair_date ใน event ล่าสุดของ sensor
            const queryCheckRepair = `
                SELECT repair_date FROM event
                WHERE id_sensor = ?
                ORDER BY timestamp DESC LIMIT 1
            `;
            const repairDate = await new Promise((resolve, reject) => {
                db.query(queryCheckRepair, [sensorId], (err, result) => {
                    if (err) {
                        console.error(`Error checking repair_date for sensor ID ${sensorId}:`, err);
                        reject(err);
                    } else {
                        resolve(result[0]?.repair_date || null);
                    }
                });
            });

            // ถ้า repair_date ไม่เป็น NULL ให้เปลี่ยน state เป็น good
            if (repairDate !== null) {
                const queryUpdateState = `UPDATE sensor SET state = 'good' WHERE id_sensor = ?`;
                await new Promise((resolve, reject) => {
                    db.query(queryUpdateState, [sensorId], (err, result) => {
                        if (err) {
                            console.error(`Error updating state to good for sensor ID ${sensorId}:`, err);
                            reject(err);
                        } else {
                            console.log(`Sensor ID ${sensorId} state updated to good.`);
                            resolve(result);
                        }
                    });
                });
            }
        }
    } catch (error) {
        console.error('Error in checkRepair:', error);
    }
};

const getAllSensorIds = async () => {
    try {
        const query = `SELECT id_sensor FROM sensor`;
        const sensorIds = await new Promise((resolve, reject) => {
            db.query(query, (err, result) => {
                if (err) {
                    console.error('Error fetching sensor IDs:', err);
                    reject(err);
                } else {
                    // แปลงผลลัพธ์เป็น array ของ id_sensor
                    resolve(result.map(row => row.id_sensor));
                }
            });
        });
        return sensorIds;
    } catch (error) {
        console.error('Error in getAllSensorIds:', error);
        throw error;
    }
};

module.exports = { fetchAndSaveSensors, fetchAndSaveSensorData, checkRepair, getAllSensorIds };