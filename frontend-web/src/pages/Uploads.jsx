import React, { useState, useRef } from "react";
import "../styles/uploads.css";

const Uploads = () => {
  const [files, setFiles] = useState(null);
  const inputRef = useRef();

  const handleDragOver = (event) => {
    event.preventDefault();
  };

  const handleDrop = (event) => {
    event.preventDefault();
    setFiles(event.dataTransfer.files);
  };
  
  const handleFileSelect = (event) => {
    setFiles(event.target.files);
  };

  const handleUpload = () => {
    if (!files) {
      alert("Please select files to upload.");
      return;
    }

    const formData = new FormData();
    Array.from(files).forEach((file) => {
      formData.append("files", file);
    });

    // Perform upload logic here (e.g., send formData to server)
    console.log("Uploading files:", formData.getAll("files"));
  };

  const clearFiles = () => {
    setFiles(null);
  };

  return (
    <div className="upload-container" onDragOver={handleDragOver} onDrop={handleDrop}>
      {!files ? (
        <>
          <h1>Drag and Drop Files to Upload</h1>
          <h2>Supported file types: PDF, Images, DWG, etc.</h2>
          <input
            type="file"
            multiple
            onChange={handleFileSelect}
            hidden
            accept=".pdf, .jpg, .jpeg, .png, .dwg , .xlsx"
            ref={inputRef}
            aria-hidden="true"
          />
          <button onClick={() => inputRef.current.click()}>Select Files</button>
        </>
      ) : (
        <>
          <ul>
            {Array.from(files).map((file, idx) => (
              <li key={idx}>{file.name}</li>
            ))}
          </ul>
          <div className="actions">
            <button onClick={clearFiles}>Cancel</button>
            <button onClick={handleUpload}>Upload</button>
          </div>
        </>
      )}
      {/* Display file name when loaded */}
      {files && (
        <div>
          <h3>File(s) selected:</h3>
          <ul>
            {Array.from(files).map((file, idx) => (
              <li key={idx}>{file.name}</li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
};

export default Uploads;