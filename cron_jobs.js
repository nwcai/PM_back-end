const cron = require('node-cron');
const { fetchAndSaveSensorData, checkRepair, getAllSensorIds } = require('./service/sensor_service'); // เพิ่ม getAllSensorIds

// ตัวแปรสำหรับเก็บช่วงเวลาล่าสุดที่ดึงข้อมูล
let lastEndTime = new Date('2025-02-20T17:00:00.000Z'); // กำหนดค่าเริ่มต้นของ start

// ตั้งค่า Cron Job ให้ทำงานทุก 5 นาที
cron.schedule('* * * * *', async () => {
    console.log('Running Cron Job: Checking repair status and fetching sensor data');

    try {
        // เรียกใช้ checkRepair ก่อน fetchAndSaveSensorData
        console.log('Checking repair status for sensors...');
        await checkRepair();

        // กำหนดช่วงเวลาเริ่มต้นและสิ้นสุด
        const start = lastEndTime; // ใช้ lastEndTime เป็นค่าเริ่มต้นของ start
        const end = new Date(start.getTime() + 30 * 60 * 1000); // ช่วงเวลาสิ้นสุดคือ 30 นาทีหลังจาก start

        // แปลงวันที่เป็น ISO string
        const startISO = start.toISOString();
        const endISO = end.toISOString();

        console.log(`Fetching data from ${startISO} to ${endISO}`);

        // ดึงรายการ sensorId ทั้งหมดจากแหล่งข้อมูล
        const sensorIds = await getAllSensorIds(); // ใช้ฟังก์ชันเพื่อดึง sensorIds ทั้งหมด
        console.log(`Found sensors: ${sensorIds.join(', ')}`);

        // ดึงข้อมูลทีละ sensorId
        for (const sensorId of sensorIds) {
            console.log(`Fetching data for sensor ID: ${sensorId}`);
            await fetchAndSaveSensorData([sensorId], startISO, endISO);
        }

        // อัปเดต lastEndTime เป็น end
        lastEndTime = end;

        console.log('Finished fetching data for this interval.');
    } catch (error) {
        console.error('Error in Cron Job:', error);
    }
});