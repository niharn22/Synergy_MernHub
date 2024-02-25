import React from 'react';
import "../styles/home.css";
import DWG from "../assets/dwg_icon.png";
import PDF from "../assets/pdf_icon.png";
import Excel from "../assets/excel_icon.png";
import Image from "../assets/image_icon.png";
import Video from "../assets/video_icon.png";

const folderFiles = [
  {
    name: 'PDF',
    type: 'folder',
    icon: PDF,
    children: [
      {
        name: 'File A1',
        type: 'file'
      },
      {
        name: 'File A2',
        type: 'file'
      }
    ]
  },
  {
    name: 'Excel Sheet',
    type: 'folder',
    icon: Excel,
    children: [
      {
        name: 'File B1',
        type: 'file'
      }
    ]
  },
  {
    name: 'DWG',
    type: 'folder',
    icon: DWG,
    children: [
      {
        name: 'File D1',
        type: 'file'
      },
      {
        name: 'File D2',
        type: 'file'
      },
      {
        name: 'File D3',
        type: 'file'
      },
      {
        name: 'File D4',
        type: 'file'
      },
      {
        name: 'File D5',
        type: 'file'
      }
    ]
  },
  {
    name: 'Images',
    type: 'folder',
    icon: Image,
    children: [
      {
        name: 'File B1',
        type: 'file'
      }
    ]
  },
  {
    name: 'Videos',
    type: 'folder',
    icon: Video,
    children: [
      {
        name: 'File B1',
        type: 'file'
      }
    ]
  },
];

const Home = ({ searchQuery }) => {

  const filteredFiles = folderFiles.filter(file => file.name.toLowerCase().includes(searchQuery.toLowerCase()));

  const renderFolderFiles = (folderFiles) => {
    return folderFiles.map((item, index) => (
      <div key={index} className={item.type === 'folder' ? 'folder' : 'file'}>
        {item.type === 'folder' ? (
          <div className='folder-type'>
            <img src={item.icon} alt='icon' className='icon-home'/>
            <strong>{item.name}</strong>
            <div >
              {renderFolderFiles(item.children)}
            </div>
          </div>
        ) : null} 
      </div>
    ));
  };

  return (
    <div className="home-container">
      {renderFolderFiles(filteredFiles)}
    </div>
  );
};

export default Home;
