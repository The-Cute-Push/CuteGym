import { useState } from 'react';

function ClassForm({ onAdd }) {
  const [modality, setModality] = useState('');
  const [instructor, setInstructor] = useState('');
  const [duration, setDuration] = useState('');

  const handleSubmit = () => {
    if (modality && instructor && duration) {
      onAdd({ modality, instructor, duration });
      setModality('');
      setInstructor('');
      setDuration('');
    }
  };

  return (
    <div className="form-box">
      <input
        type="text"
        placeholder="Digite a modalidade"
        value={modality}
        onChange={(e) => setModality(e.target.value)}
      />
      <input
        type="text"
        placeholder="Digite o instrutor"
        value={instructor}
        onChange={(e) => setInstructor(e.target.value)}
      />
      <input
        type="text"
        placeholder="Digite as horas"
        value={duration}
        onChange={(e) => setDuration(e.target.value)}
      />
      <button onClick={handleSubmit}>Cadastrar</button>
    </div>
  );
}

export default ClassForm;
