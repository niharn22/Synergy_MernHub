import React, { useState } from 'react';
import "../styles/navbar.css";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faMagnifyingGlass, faTimes, faGear, faDownload } from '@fortawesome/free-solid-svg-icons';

const Navbar = () => {
  const [searchTerm, setSearchTerm] = useState("");

  const handleInputChange = (event) => {
    setSearchTerm(event.target.value);
  };

  const clearSearchTerm = () => {
    setSearchTerm("");
  };

  return (
    <div className="navbar">
      <div className="search-container">
        <FontAwesomeIcon icon={faMagnifyingGlass} className="icon mg-icon"/>
        <input
          className="search-bar"
          placeholder="Enter the file type"
          value={searchTerm}
          onChange={handleInputChange}
        />
        {searchTerm && (
          <FontAwesomeIcon
            icon={faTimes}
            className="icon xm-icon"
            onClick={clearSearchTerm}
          />
        )}
      </div>
      <div className="settings">
        <FontAwesomeIcon icon={faGear} className="s-icon" />
      </div>
      <div className="download">
        <FontAwesomeIcon icon={faDownload} className="d-icon" />
      </div>
    </div>
  );
}

export default Navbar;
