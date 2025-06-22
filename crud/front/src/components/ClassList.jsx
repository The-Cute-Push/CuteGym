import { useState } from 'react';

function ClassForm({ onAdd }) {
  const [id_modalities, setIdModalities] = useState('');
  const [id_instructor, setIdInstructor] = useState('');
  const [dt_hour_class, setDtHourClass] = useState('');

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
      <input
        type="number"
        placeholder="ID da modalidade"
        value={id_modalities}
        onChange={(e) => setIdModalities(e.target.value)}
      />
      <input
        type="number"
        placeholder="ID do instrutor"
        value={id_instructor}
        onChange={(e) => setIdInstructor(e.target.value)}
      />
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

      {/* Cabeçalho da tabela */}
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
