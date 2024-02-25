import React, { useState } from 'react';
import PDF from "../assets/pdf_icon.png";
import { faXmark } from '@fortawesome/free-solid-svg-icons';
import "../styles/recents.css";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

const Recent = () => {
  const files = [
    {
      name: "SYN3RGY PROBLEM STATEMENTS.pdf",
      uri: "https://publuu.com/flip-book/411717/930759",
      icon: PDF
    },
    {
      name: "Untitled.pdf",
      uri: "https://publuu.com/flip-book/411717/930772",
      icon: PDF
    },
    {
      name: "SPONSORSHIP BROCHURE.pdf",
      uri: "https://publuu.com/flip-book/411717/930775",
      icon: PDF
    }
  ];

  const [selectedFile, setSelectedFile] = useState(null);

  const handleFileClick = (file) => {
    setSelectedFile(file.uri === selectedFile ? null : file.uri);
  };

  const handleCloseClick = () => {
    setSelectedFile(null);
  };

  return (
    <div className="recent-container">
      {files.map((file, index) => (
        <div key={index} className="file-item" onClick={() => handleFileClick(file)}>
          <img src={file.icon} alt={file.name} className='icon-recent'/>
          <a className="anchor" rel="noopener noreferrer">{file.name}</a>
          {selectedFile === file.uri && (
            <>
              <iframe src={file.uri} title={file.name} className="pdf-iframe"></iframe>
              <FontAwesomeIcon icon={faXmark} className='close-icon' onClick={handleCloseClick} />
            </>
          )}
        </div>
      ))}
    </div>
  );
};

export default Recent;
