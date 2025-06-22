import { useEffect, useState } from 'react'; 
import axios from 'axios';

function ClassForm({ onAdd }) {
  // Agora iniciamos como null (valor numérico)
  const [id_modalities, setIdModalities] = useState(null);
  const [id_instructor, setIdInstructor] = useState(null);
  const [dt_hour_class, setDtHourClass] = useState('');

  const [modalities, setModalities] = useState([]);
  const [instructors, setInstructors] = useState([]);

  useEffect(() => {
    async function fetchOptions() {
      try {
        const modRes = await axios.get('http://localhost:3001/classes/modalities');
        const instRes = await axios.get('http://localhost:3001/classes/instructors');
        setModalities(modRes.data);
        setInstructors(instRes.data);
      } catch (error) {
        console.error('Erro ao carregar opções:', error.message);
      }
    }
    fetchOptions();
  }, []);

  const handleSubmit = () => {
    if (id_modalities && id_instructor && dt_hour_class) {
      onAdd({ id_modalities, id_instructor, dt_hour_class });
      setIdModalities(null);
      setIdInstructor(null);
      setDtHourClass('');
    }
  };

  return (
    <div className="form-box">
      <select 
        value={id_modalities ?? ''} 
        onChange={(e) => setIdModalities(Number(e.target.value))}
      >
        <option value="">Selecione a modalidade</option>
        {modalities.map((mod) => (
          <option key={mod.id} value={mod.id}>{mod.name}</option>
        ))}
      </select>

      <select 
        value={id_instructor ?? ''} 
        onChange={(e) => setIdInstructor(Number(e.target.value))}
      >
        <option value="">Selecione o instrutor</option>
        {instructors.map((inst) => (
          <option key={inst.id} value={inst.id}>{inst.name}</option>
        ))}
      </select>

      <input
        type="datetime-local"
        placeholder="Data e Hora da Aula"
        value={dt_hour_class}
        onChange={(e) => setDtHourClass(e.target.value)}
      />

      <button onClick={handleSubmit}>Cadastrar</button>
    </div>
  );
}

export default ClassForm;
