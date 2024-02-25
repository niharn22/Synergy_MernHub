import React, { useState } from 'react';
import "../styles/storage.css";
import DWG from "../assets/dwg_icon.png";
import PDF from "../assets/pdf_icon.png";
import Excel from "../assets/excel_icon.png";
import Image from "../assets/image_icon.png";
import Video from "../assets/video_icon.png";

const Storage = () => {
  const [storageData] = useState({
    totalCapacity: 1, 
    usedCapacity: 0.045,  
 });

  const folderFiles = [
    {
      name: 'PDF',
      type: 'folder',
      icon: PDF
    },
    {
      name: 'Excel Sheet',
      type: 'folder',
      icon: Excel
    },
    {
      name: 'DWG',
      type: 'folder',
      icon: DWG
    },
    {
      name: 'Images',
      type: 'folder',
      icon: Image
    },
    {
      name: 'Videos',
      type: 'folder',
      icon: Video
    },
  ];

  const handleFiles = () => {

  }

  const usedPercentage = (storageData.usedCapacity / storageData.totalCapacity) * 100;

  return (
    <div className="storage-container">
      <div className="progress-bar" onClick={handleFiles}>
        <div className="progress" style={{ width: `${usedPercentage}%` }}></div>
      </div>
      <div className="usage-details">
        <span>{storageData.usedCapacity} GB used</span>
        <span>{storageData.totalCapacity} GB total</span>
      </div>
    </div>
  );
};

export default Storage;
