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
