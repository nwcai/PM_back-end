const cron = require('node-cron');
const axios = require('axios');

// ตั้ง Cron Job ให้ตรวจสอบสถานะเซ็นเซอร์ทุก 5 นาที
cron.schedule('* * * * *', async () => {
  console.log('Running sensor state check...');
  try {
    const url = 'http://localhost:3000/api/machine/check-sensor-state';
    console.log(`Calling API: ${url}`);
    const response = await axios.get(url);
    console.log('Sensor state checked:', response.data);
  } catch (error) {
    console.error('Error checking sensor state:', error.response?.data || error.message);
  }
});

console.log('Cron job for sensor state check is running...');