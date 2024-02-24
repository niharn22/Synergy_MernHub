// index.js
const express = require('express');
const mongoose = require('mongoose');
const multer = require('multer');
const Folder = require('./models/folderModel');
const File = require('./models/fileModel');

const app = express();
app.use(express.json());

// Multer configuration
const upload = multer({ dest: 'uploads/' }); // Destination folder for temporarily storing uploaded files

mongoose.connect('mongodb+srv://user2000:nihar123@cluster0.ku5uugz.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0')
  .then(() => {
    console.log('Connected to MongoDB');
  })
  .catch(err => {
    console.error('Failed to connect to MongoDB', err);
  });

// Route to add a folder
app.post('/folders', async (req, res) => {
  try {
    const { name } = req.body;
    const folder = new Folder({ name });
    const savedFolder = await folder.save();
    res.json(savedFolder);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Route to create a file within a folder
app.post('/folders/:folderId/files', upload.single('file'), async (req, res) => {
  try {
    const { name, type } = req.body;
    const { folderId } = req.params;
    const filePath = req.file.path;

    const folder = await Folder.findById(folderId);
    if (!folder) {
      return res.status(404).json({ error: 'Folder not found' });
    }

    const file = new File({
      name,
      type,
      folder: folder._id,
      filePath: filePath // Storing file path in the database
    });
    const savedFile = await file.save();
    res.json(savedFile);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
