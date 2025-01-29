const express = require('express');
const UserController = require('../controller/user_controller.js');

const router = express.Router();

router.get('/all',UserController.GetAllUser)
router.get('/id/:id',UserController.GetAllUserByID)
router.post('/create',UserController.CreateUser)//
router.post('/update/:id',UserController.UpdateUser)//

module.exports = router;