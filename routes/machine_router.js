const express = require('express');
const MachineController = require('../controller/machine_controller.js');

const router = express.Router();

router.get('/all', MachineController.GetAllMachines);
router.get('/allname', MachineController.GetAllNameMachine);
router.get('/id/:id', MachineController.GetMachinesById);
router.post('/create', MachineController.CreateMachine);
router.put('/update/:id', MachineController.UpdateMachine);
router.get('/delete/:id', MachineController.DeleteMachinesById);
router.post('/addevent', MachineController.AddEvent);
router.get('/event/:id_machine', MachineController.GetEventsByMachineId);
router.get('/check-sensor-state', MachineController.CheckSensorState);
router.get('/eventid/:id', MachineController.GetEventById);
router.post('/addrepair', MachineController.AddRepair);

module.exports = router;
