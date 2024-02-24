// folderModel.js
const mongoose = require('mongoose');

const folderSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  }
});

const Folder = mongoose.model('Folder', folderSchema);

module.exports = Folder;
