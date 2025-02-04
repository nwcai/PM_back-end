const express = require('express');
const MachineController = require('../controller/machine_controller.js');

const router = express.Router();

router.get('/all', MachineController.GetAllMachines);
//router.get('/id/:id', MachineController.GetMachineByID);
router.post('/create', MachineController.CreateMachine);
//router.post('/update/:id', MachineController.UpdateMachine);

module.exports = router;
