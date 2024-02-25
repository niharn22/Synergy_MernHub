import React from 'react';
import "../styles/currentUser.css";
import User from "../assets/Sameer.jpg";

const currentUser = () => {
  return (
    <div className="profile-container">
      <div className="profile-header">
        <h2>User Profile</h2>
      </div>
      <div className="profile-info">
        <div className="avatar">
          <img src={User} alt="User Avatar" />
        </div>
        <div className="user-details">
          <h3>Sameer Gupta</h3>
          <p>Email: sameergupta79711@gmail.com</p>
          <p>Location: Mumbai, Maharashtra</p>
        </div>
      </div>
    </div>
  );
};

export default currentUser;