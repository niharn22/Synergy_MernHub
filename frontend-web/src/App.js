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
import Sidebar from "./components/sidebar";
import "./styles/global.css";

function App() {
  return (
    <BrowserRouter>
      <Sidebar>
        <Routes>
          <Route path="/" element={<Home/>} />
          <Route path="/myhub" element={<MyHub/>} />
          <Route path="/uploads" element={<Uploads/>} />
          <Route path="/recents" element={<Recent/>} />
          <Route path="/favorites" element={<Favorites/>} />
          <Route path="/bimviewer" element={<BIMViewer/>} />
          <Route path="/bin" element={<Bin/>} />
          <Route path="/storage" element={<Storage/>} />
        </Routes>
      </Sidebar>
      <Navbar />
    </BrowserRouter>
  );
}

export default App;