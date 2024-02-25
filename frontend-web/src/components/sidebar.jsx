import React, { useState } from 'react';
import Logo from "../assets/hubspot.svg"
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faHouse, faCloud, faTrash, faClock, faStar, faUpload, faBars, faStreetView, faUser } from '@fortawesome/free-solid-svg-icons';
import { faHubspot } from '@fortawesome/free-brands-svg-icons';
import { NavLink } from "react-router-dom";
import "../styles/sidebar.css";

const Sidebar = ({ children }) => {

    const[isOpen ,setIsOpen] = useState(false);
    const toggle = () => setIsOpen (!isOpen);

    const menuItem = [
        {
            path: "/",
            name: "Home",
            icon: <FontAwesomeIcon icon={faHouse} />
        },
        // {
        //     path: "/myhub",
        //     name: "My Hub",
        //     icon: <FontAwesomeIcon icon={faHubspot} />
        // },
        {
            path: "/uploads",
            name: "Uploads",
            icon: <FontAwesomeIcon icon={faUpload} />
        },
        {
            path: "/recents",
            name: "Recents",
            icon: <FontAwesomeIcon icon={faClock} />
        },
        // {
        //     path: "/favorites",
        //     name: "Favorites",
        //     icon: <FontAwesomeIcon icon={faStar} />
        // },
        {
            path: "/bimviewer",
            name: "DWG Viewer",
            icon: <FontAwesomeIcon icon={faStreetView} />
        },
        // {
        //     path: "/bin",
        //     name: "Bin",
        //     icon: <FontAwesomeIcon icon={faTrash} />
        // },
        {
            path: "/storage",
            name: "Storage",
            icon: <FontAwesomeIcon icon={faCloud} />
        },
        {
            path: "/user",
            name: "Sameer Gupta",
            icon: <FontAwesomeIcon icon={faUser} />
        }
    ];

    return (
        <div className="container">
            <div style={{width: isOpen ? "300px" : "50px"}} className="sidebar">
                <div className="top_section">
                    <img src={Logo} style={{display: isOpen ? "block" : "none"}} className="logo"></img>
                    <h3 style={{display: isOpen ? "block" : "none"}}>ConstructHub</h3>
                    <div style={{marginLeft: isOpen ? "40px" : "0px"}} className="bars">
                        <FontAwesomeIcon icon={faBars} onClick={toggle}/>
                    </div>
                </div>
                {
                    menuItem.map((item, index)=>(
                        <NavLink to={item.path} key={index} className="link" activeclassname="active">
                            <div className="icon">{item.icon}</div>
                            <div style={{display: isOpen ? "block" : "none"}} className="link_text">{item.name}</div>
                        </NavLink>
                    ))
                }
            </div>
            <main>{children}</main>
        </div>
    );
}

export default Sidebar;