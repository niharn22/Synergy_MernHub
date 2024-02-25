import React, { useState } from 'react';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Navbar from "./components/navbar";
import Home from "./pages/Home"
import MyHub from "./pages/MyHub";
import Uploads from "./pages/Uploads";
import Recent from "./pages/Recent";
import Favorites from "./pages/Favorites";
import BIMViewer from "./pages/BIMViewer";
import Bin from "./pages/Bin";
import Storage from "./pages/Storage";
import currentUser from "./pages/currentUser";
import Sidebar from "./components/sidebar";
import "./styles/global.css";

function App() {

  const [searchQuery, setSearchQuery] = useState('');

  const handleSearch = (query) => {
    setSearchQuery(query);
  };

  return (
    <BrowserRouter>
      <Sidebar>
        <Routes>
          <Route path="/" element={<Home searchQuery={searchQuery}/>} />
          <Route path="/myhub" element={<MyHub/>} />
          <Route path="/uploads" element={<Uploads/>} />
          <Route path="/recents" element={<Recent/>} />
          <Route path="/favorites" element={<Favorites/>} />
          <Route path="/bimviewer" element={<BIMViewer/>} />
          <Route path="/bin" element={<Bin/>} />
          <Route path="/storage" element={<Storage/>} />
          <Route path="/storage" element={<currentUser/>} />
        </Routes>
      </Sidebar>
      <Navbar 
        onSearch={handleSearch}
      />
    </BrowserRouter>
  );
}

export default App;