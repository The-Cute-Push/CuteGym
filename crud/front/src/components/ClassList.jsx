export default function ClassList({ classes }) {
  return (
    <div>
      <div className="table-header">
        <div className="cell">id_class</div>
        <div className="cell">id_modalities</div>
        <div className="cell">id_instructor</div>
        <div className="cell">dt_hour_class</div>
      </div>

      <div className="table-body">
        {classes.map((cls) => (
          <div key={cls.id} className="row">
            <div className="cell">{cls.id}</div>
            <div className="cell">{cls.modality}</div>
            <div className="cell">{cls.instructor}</div>
            <div className="cell">{cls.duration}</div>
          </div>
        ))}
      </div>
    </div>
  );
}
