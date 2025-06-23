import { useEffect, useState } from 'react';
import axios from 'axios';
import { toast } from 'react-toastify';

const API_URL = 'http://localhost:3002';

function ClassForm({ onAdd }) {
  const [id_modalities, setIdModalities] = useState('');
  const [id_instructor, setIdInstructor] = useState('');
  const [dt_hour_class, setDtHourClass] = useState('');

  const [modalities, setModalities] = useState([]);
  const [instructors, setInstructors] = useState([]);

  useEffect(() => {
    async function fetchOptions() {
      try {
        const modRes = await axios.get(`${API_URL}/classes/modalities`);
        const instRes = await axios.get(`${API_URL}/classes/instructors`);
        setModalities(modRes.data);
        setInstructors(instRes.data);
      } catch (error) {
        console.error('Erro ao carregar opções:', error.message);
      }
    }
    fetchOptions();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (id_modalities && id_instructor && dt_hour_class) {
      try {
        await axios.post(`${API_URL}/classes`, {
          id_modalities,
          id_instructor,
          dt_hour_class
        });
        setIdModalities(null);
        setIdInstructor(null);
        setDtHourClass('');
        await onAdd(); 
      } catch {
        toast.error('Erro ao criar a classe!');
      }
    } else {
      toast.warn('Preencha todos os campos');
    }
  };

  return (
    <form className="form-box" onSubmit={handleSubmit}>
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

      <button type="submit" style={{ zIndex: 10 }}>
        Cadastrar
      </button>
    </form>
  );
}

export default ClassForm;