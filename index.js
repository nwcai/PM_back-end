const express = require('express');
const cors = require('cors');
const fs = require('fs');
const csvParser = require('csv-parser');
const multer = require('multer');
const UserRouter = require('./routes/user_router.js');
const machineRouter = require('./routes/machine_router.js')
const app = express();
const port = 3000;

// Middleware should be defined BEFORE routes
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Then define routes
app.use('/api/user', UserRouter);
app.use('/api/machine', machineRouter);

// กำหนดการอัปโหลดไฟล์
const upload = multer({ dest: 'uploads/' });

// Endpoint สำหรับอัปโหลดไฟล์ CSV
app.post('/upload', upload.single('file'), (req, res) => {
  const filePath = req.file.path;
  const results = [];

  fs.createReadStream(filePath)
    .pipe(csvParser())
    .on('data', (data) => results.push(data))
    .on('end', () => {
      fs.unlinkSync(filePath);
      res.json(results);
    });
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});