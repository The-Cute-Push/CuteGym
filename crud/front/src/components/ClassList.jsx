import { useEffect, useState } from 'react';
import axios from 'axios';

function ClassForm({ onAdd }) {
  const [id_modalities, setIdModalities] = useState('');
  const [id_instructor, setIdInstructor] = useState('');
  const [dt_hour_class, setDtHourClass] = useState('');

  const [modalities, setModalities] = useState([]);
  const [instructors, setInstructors] = useState([]);

  useEffect(() => {
    async function fetchData() {
      try {
        const modRes = await axios.get('http://localhost:3001/classes/modalities');
        const instRes = await axios.get('http://localhost:3001/classes/instructors');        
        setModalities(modRes.data);
        setInstructors(instRes.data);
      } catch (err) {
        console.error('Erro ao buscar modalidades/instrutores', err);
      }
    }
    fetchData();
  }, []);

  const handleSubmit = () => {
    if (id_modalities && id_instructor && dt_hour_class) {
      onAdd({ id_modalities, id_instructor, dt_hour_class });
      setIdModalities('');
      setIdInstructor('');
      setDtHourClass('');
    }
  };

  return (
    <div className="form-box">
      <select value={id_modalities} onChange={(e) => setIdModalities(e.target.value)}>
        <option value="">Selecione a modalidade</option>
        {modalities.map((mod) => (
          <option key={mod.id} value={mod.id}>{mod.name}</option>
        ))}
      </select>

      <select value={id_instructor} onChange={(e) => setIdInstructor(e.target.value)}>
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

export default function ClassList({ classes, onAdd }) {
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 5;

  const indexOfLast = currentPage * itemsPerPage;
  const indexOfFirst = indexOfLast - itemsPerPage;
  const currentClasses = classes.slice(indexOfFirst, indexOfLast);

  const totalPages = Math.ceil(classes.length / itemsPerPage);

  return (
    <div className="table-container">
      <h2>Lista de Aulas</h2>

      <ClassForm onAdd={onAdd} />

      <div className="table-header">
        <div className="cell">ID</div>
        <div className="cell">Modalidade</div>
        <div className="cell">Instrutor</div>
        <div className="cell">Data/Hora</div>
      </div>

      <div className="table-body">
        {currentClasses.map((cls) => (
          <div key={cls.id} className="row">
            <div className="cell">{cls.id}</div>
            <div className="cell">{cls.modality}</div>
            <div className="cell">{cls.instructor}</div>
            <div className="cell">{cls.datetime}</div>
          </div>
        ))}
      </div>

      {totalPages > 1 && (
        <div className="pagination">
          <button
            onClick={() => setCurrentPage((p) => Math.max(p - 1, 1))}
            disabled={currentPage === 1}
          >
            &lt; Anterior
          </button>
          <span>
            Página {currentPage} de {totalPages}
          </span>
          <button
            onClick={() => setCurrentPage((p) => Math.min(p + 1, totalPages))}
            disabled={currentPage === totalPages}
          >
            Próximo &gt;
          </button>
        </div>
      )}
    </div>
  );
}
