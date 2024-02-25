import React, { useState } from 'react';
import { Canvas } from "@react-three/fiber";
import { useGLTF, Stage, PresentationControls } from "@react-three/drei";
import "../styles/bimviewer.css";

function Model(props) {
  const { scene } = useGLTF(props.url);
  return <primitive object={scene} {...props} />;
}

const BIMViewer = () => {
  const [modelUrl, setModelUrl] = useState(null);

  const handleFileUpload = (event) => {
    const file = event.target.files[0];
    if (file) {
      const url = URL.createObjectURL(file);
      setModelUrl(url);
    }
  };

  return (
    modelUrl !== null ? (
    <div className="canvas-container">
        <Canvas dpr={[1,2]} shadows camera={{ fov: 45 }} style={{ width: "100%", height: "100%" }} className="canvas">
          <color attach="background" args={["#101010"]} />
          <PresentationControls speed={1.5} global zoom={0.5} polar={[-0.1, Math.PI / 4]}>
            <Stage environment={"sunset"}>
              {modelUrl && <Model url={modelUrl} scale={0.01} />}
            </Stage>
          </PresentationControls>
        </Canvas>
    </div>
    ) : (
      <input type="file" accept=".glb" onChange={handleFileUpload} className="glb-input"/>
    )
  );
}

export default BIMViewer;
