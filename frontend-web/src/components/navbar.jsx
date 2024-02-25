  import React, { useState } from 'react';
  import "../styles/navbar.css";
  import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
  import { faMagnifyingGlass, faTimes, faGear, faDownload } from '@fortawesome/free-solid-svg-icons';

  const Navbar = ({ onSearch }) => {
    const [searchQuery, setSearchQuery] = useState('');

    const handleSearchInputChange = (event) => {
      setSearchQuery(event.target.value);
      onSearch(event.target.value); 
    };

    const clearSearchTerm = () => {
      setSearchQuery("");
      onSearch(""); // Clear the search query
    };

    return (
      <div className="navbar">
        <div className="search-container">
          <FontAwesomeIcon icon={faMagnifyingGlass} className="icon mg-icon"/>
          <input
            type='text'
            className="search-bar"
            placeholder="Enter the file type"
            value={searchQuery}
            onChange={handleSearchInputChange}
          />
          {searchQuery && (
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
