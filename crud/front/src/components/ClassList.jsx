import { useState, useEffect } from 'react';
import ClassForm from './ClassForm';
import { toast } from 'react-toastify';
import axios from 'axios';

const API_URL = 'http://localhost:3002/classes';

export default function ClassList({ classes, onAdd }) {
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 5;
  const [sortBy, setSortBy] = useState('id');
  const [sortOrder, setSortOrder] = useState('desc');
  const [editClass, setEditClass] = useState(null);
  const [editDate, setEditDate] = useState('');
  const [editModality, setEditModality] = useState('');
  const [editInstructor, setEditInstructor] = useState('');
  const [modalities, setModalities] = useState([]);
  const [instructors, setInstructors] = useState([]);
  const [deleteTarget, setDeleteTarget] = useState(null);

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

  useEffect(() => {
    const fetchData = async () => {
      try {
        const [modalitiesRes, instructorsRes] = await Promise.all([
          axios.get('http://localhost:3002/classes/modalities'),
          axios.get('http://localhost:3002/classes/instructors'),
        ]);
        setModalities(modalitiesRes.data);
        setInstructors(instructorsRes.data);
      } catch {
        toast.error('Erro ao carregar modalidades e instrutores');
      }
    };
    fetchData();
  }, []);

  const handleEditClick = (cls) => {
    setEditClass(cls);
    setEditDate(cls.datetime.replace(' ', 'T').slice(0, 16));
    
    setEditModality(cls.id_modalities ?? '');
    setEditInstructor(cls.id_instructor ?? '');
  };

  const handleEditSave = async () => {
    try {
      const date = new Date(editDate);
      const pad = n => n.toString().padStart(2, '0');
      const formatted =
        `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())} ` +
        `${pad(date.getHours())}:${pad(date.getMinutes())}:${pad(date.getSeconds())}`;

      await axios.put(`${API_URL}/${editClass.id}`, {
        id_modalities: Number(editModality),
        id_instructor: Number(editInstructor),
        dt_hour_class: formatted
      });
      toast.success('Aula atualizada com sucesso!');
      setEditClass(null);
      await onAdd();
    } catch {
      toast.error('Erro ao atualizar a aula!');
    }
  };

  const handleEditCancel = () => {
    setEditClass(null);
  };

  const sortIcon = (column) =>
    sortBy === column ? (sortOrder === 'asc' ? ' ▲' : ' ▼') : '';

  return (
    <div className="table-container">

      <ClassForm onAdd={handleAdd} />

      {editClass && (
        <div className="modal-overlay">
          <div className="modal-content">
            <button className="modal-close" onClick={handleEditCancel} title="Fechar">
              &times;
            </button>
            <h3>Editar Aula</h3>
            <label style={{ marginTop: 8, marginBottom: 4 }}>Modalidade</label>
            <select
              className="modal-button"
              value={editModality}
              onChange={e => setEditModality(e.target.value)}
            >
            <option value="">Selecione</option>
            {modalities.map((m) => (
              <option key={m.id} value={m.id}>
                {m.name}
              </option>
            ))}
            </select>
            <label style={{ marginTop: 8, marginBottom: 4 }}>Instrutor</label>
            <select
              className="modal-button"
              value={editInstructor}
              onChange={e => setEditInstructor(Number(e.target.value))}
            >
            <option value="">Selecione</option>
            {instructors.map((inst) => (
              <option key={inst.id} value={inst.id}>
                {inst.name}
              </option>
            ))}
            </select>
            <label style={{ marginTop: 8, marginBottom: 4 }}>Data/Hora</label>
            <input
              type="datetime-local"
              value={editDate}
              onChange={e => setEditDate(e.target.value)}
              className="modal-button"
            />
            <div className="modal-actions">
              <button className="btn-green" onClick={handleEditSave}>Salvar</button>
              <button className="btn-green" style={{ background: "#333" }} onClick={handleEditCancel}>Cancelar</button>
            </div>
          </div>
        </div>
      )}

      {deleteTarget && (
        <div className="modal-overlay">
          <div className="modal-content">
            <button className="modal-close" onClick={() => setDeleteTarget(null)} title="Fechar">
              &times;
            </button>
            <h3 style={{ color: "#ff5858" }}>Confirmar Exclusão</h3>
            <p>Tem certeza que deseja excluir a aula <b>{deleteTarget.id}</b>?</p>
            <div className="modal-actions">
              <button className="btn-red"
                onClick={async () => {
                  try {
                    await axios.delete(`${API_URL}/${deleteTarget.id}`);
                    toast.success('Aula excluída com sucesso!');
                    setDeleteTarget(null);
                    await onAdd();
                  } catch {
                    toast.error('Erro ao excluir a aula!');
                  }
                }}
              >
                Excluir
              </button>
              <button className="btn-green" style={{ background: "#333" }} onClick={() => setDeleteTarget(null)}>
                Cancelar
              </button>
            </div>
          </div>
        </div>
      )}

      <h2>Lista de Aulas</h2>

      <div className="table-header">
        <div className="cell" style={{ cursor: 'pointer' }} onClick={() => handleSort('id')}>
          ID{sortIcon('id')}
        </div>
        <div className="cell" style={{ cursor: 'pointer' }} onClick={() => handleSort('modality')}>
          Modalidade{sortIcon('modality')}
        </div>
        <div className="cell" style={{ cursor: 'pointer' }} onClick={() => handleSort('instructor')}>
          Instrutor{sortIcon('instructor')}
        </div>
        <div className="cell" style={{ cursor: 'pointer' }} onClick={() => handleSort('datetime')}>
          Data/Hora{sortIcon('datetime')}
        </div>
        <div className="cell">Ações</div>
      </div>

      <div className="table-body">
        {currentClasses.map((cls) => (
          <div key={cls.id} className="row">
            <div className="cell">{cls.id}</div>
            <div className="cell">{cls.modality}</div>
            <div className="cell">{cls.instructor}</div>
            <div className="cell">{cls.datetime}</div>
            <div className="cell" style={{ display: 'flex', gap: 8 }}>
              <button className="btn-green" onClick={() => handleEditClick(cls)}>Editar</button>
              <button className="btn-red" onClick={() => setDeleteTarget(cls)}>Excluir</button>
            </div>
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