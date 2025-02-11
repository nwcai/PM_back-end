const express = require('express');
const SensorController = require('../controller/sensor_controller.js');

const router = express.Router();

router.get('/all',SensorController.GetAllSensor)
router.get('/id/:id',SensorController.GetSensorById)
router.post('/create', SensorController.CreateSensor);
router.post('/update/:id', SensorController.UpdateSensor);
router.get('/delete/:id', SensorController.DeletesensorById);

module.exports = router;