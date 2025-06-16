import { useEffect, useState } from 'react';
import ClassList from './components/ClassList';
import ClassForm from './components/ClassForm';
import './styles/theme.css';

function App() {
  const [classes, setClasses] = useState([]);

  useEffect(() => {
    // Simulando fetch
    const data = [
      { id: 1, modality: 'Musculação', instructor: 'Robson', duration: '1:00' },
      { id: 2, modality: 'Aeróbico', instructor: 'Carlos', duration: '0:30' },
      // adicione mais para testar o scroll
    ];
    setClasses(data);
  }, []);

  const handleAddClass = (newClass) => {
    setClasses((prev) => [...prev, { id: prev.length + 1, ...newClass }]);
  };

  return (
    <div className="main-container">
      <div className="table-container">
        <ClassList classes={classes} />
      </div>
      <div className="form-container">
        <ClassForm onAdd={handleAddClass} />
      </div>
    </div>
  );
}

export default App;
