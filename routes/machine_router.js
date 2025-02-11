const express = require('express');
const MachineController = require('../controller/machine_controller.js');

const router = express.Router();

router.get('/all', MachineController.GetAllMachines);
router.get('/allname', MachineController.GetAllNameMachine)
router.get('/id/:id', MachineController.GetMachinesById);
router.post('/create', MachineController.CreateMachine);
router.post('/update/:id', MachineController.UpdateMachine);
router.get('/delete/:id', MachineController.DeleteMachinesById);

module.exports = router;
