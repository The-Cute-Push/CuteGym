CREATE NONCLUSTERED INDEX idx_classes_modality
ON classes (id_modalities);

CREATE NONCLUSTERED INDEX idx_classes_instructor
ON classes (id_instructor);

CREATE NONCLUSTERED INDEX idx_classes_dt
ON classes (dt_hour_class);