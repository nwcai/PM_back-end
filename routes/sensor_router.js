const express = require('express');
const SensorController = require('../controller/sensor_controller.js');

const router = express.Router();

router.get('/all/:id_machine',SensorController.GetAllSensor)
router.get('/id/:id',SensorController.GetSensorById)
router.post('/create', SensorController.CreateSensor);
router.put('/update/:id', SensorController.UpdateSensor);
router.get('/delete/:id', SensorController.DeletesensorById);

module.exports = router;