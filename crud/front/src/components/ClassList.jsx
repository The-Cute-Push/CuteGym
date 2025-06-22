import { useState } from 'react';
import ClassForm from './ClassForm';
import { toast } from 'react-toastify';

export default function ClassList({ classes, onAdd }) {
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 5;

  const [sortBy, setSortBy] = useState('id');
  const [sortOrder, setSortOrder] = useState('desc');

  const handleSort = (column) => {
    if (sortBy === column) {
      setSortOrder(sortOrder === 'asc' ? 'desc' : 'asc');
    } else {
      setSortBy(column);
      setSortOrder('asc');
    }
  };

  const sortedClasses = [...classes].sort((a, b) => {
    let valA = a[sortBy];
    let valB = b[sortBy];

    if (sortBy === 'datetime') {
      valA = new Date(valA);
      valB = new Date(valB);
    }
    if (typeof valA === 'string' && typeof valB === 'string') {
      if (sortOrder === 'asc') return valA.localeCompare(valB);
      return valB.localeCompare(valA);
    }
    if (sortOrder === 'asc') return valA > valB ? 1 : valA < valB ? -1 : 0;
    return valA < valB ? 1 : valA > valB ? -1 : 0;
  });

  const indexOfLast = currentPage * itemsPerPage;
  const indexOfFirst = indexOfLast - itemsPerPage;
  const currentClasses = sortedClasses.slice(indexOfFirst, indexOfLast);

  const totalPages = Math.ceil(sortedClasses.length / itemsPerPage);

  const handleAdd = async (newClass) => {
    try {
      await onAdd(newClass);
      toast.success('Classe criada com sucesso!');
    } catch {
      toast.error('Erro ao criar a classe!');
    }
  };

  const sortIcon = (column) =>
    sortBy === column ? (sortOrder === 'asc' ? ' ▲' : ' ▼') : '';

  return (
    <div className="table-container">
      <h2>Lista de Aulas</h2>

      <ClassForm onAdd={handleAdd} />

      <div className="table-header">
        <div
          className="cell"
          style={{ cursor: 'pointer' }}
          onClick={() => handleSort('id')}
        >
          ID{sortIcon('id')}
        </div>
        <div
          className="cell"
          style={{ cursor: 'pointer' }}
          onClick={() => handleSort('modality')}
        >
          Modalidade{sortIcon('modality')}
        </div>
        <div
          className="cell"
          style={{ cursor: 'pointer' }}
          onClick={() => handleSort('instructor')}
        >
          Instrutor{sortIcon('instructor')}
        </div>
        <div
          className="cell"
          style={{ cursor: 'pointer' }}
          onClick={() => handleSort('datetime')}
        >
          Data/Hora{sortIcon('datetime')}
        </div>
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