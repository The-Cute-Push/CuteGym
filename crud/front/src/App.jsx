import { useEffect, useState } from 'react';
import ClassList from './components/ClassList';
import './App.css';
import axios from 'axios';

function App() {
  const [classes, setClasses] = useState([]);

  const fetchClasses = async () => {
    const res = await axios.get('http://localhost:3001/classes');
    setClasses(res.data);
  };

  const addClass = async (newClass) => {
    await axios.post('http://localhost:3001/classes', newClass);
    fetchClasses();
  };

  useEffect(() => {
    fetchClasses();
  }, []);

  return (
    <div className="main-container">
      <h1>Cadastro de Aulas</h1>
      <ClassList classes={classes} onAdd={addClass} />
    </div>
  );
}

export default App;
