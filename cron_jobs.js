const cron = require('node-cron');
const { fetchAndSaveSensorData, checkRepair, getAllSensorIds } = require('./service/sensor_service'); // เพิ่ม getAllSensorIds

// ตั้งค่า Cron Job ให้ทำงานทุก 5 นาที
cron.schedule('* * * * *', async () => {
    console.log('Running Cron Job: Checking repair status and fetching sensor data');

    try {
        // เรียกใช้ checkRepair ก่อน fetchAndSaveSensorData
        console.log('Checking repair status for sensors...');
        await checkRepair();

        // กำหนดช่วงเวลาเริ่มต้นและสิ้นสุดโดยใช้เวลาปัจจุบัน
        const now = new Date(); // เวลาปัจจุบัน
        const start = new Date(now.getTime() - 30 * 60 * 1000); // 30 นาทีที่แล้ว
        const end = now; // เวลาปัจจุบัน

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

        console.log('Finished fetching data for this interval.');
    } catch (error) {
        console.error('Error in Cron Job:', error);
    }
});