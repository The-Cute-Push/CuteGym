import { useEffect, useState } from 'react';
import ClassList from './components/ClassList';
import './App.css';
import axios from 'axios';

const API_URL = 'http://localhost:3002';

function App() {
  const [classes, setClasses] = useState([]);

  const fetchClasses = async () => {
    const res = await axios.get(`${API_URL}/classes`);
    setClasses(res.data);
  };

  const addClass = async () => {
    await fetchClasses();
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
