CREATE TABLE synset_synsets (
  source_synset_id integer NOT NULL REFERENCES synsets,
  target_synset_id integer NOT NULL REFERENCES synsets,
  target_pos pos NOT NULL,
  pointer_symbol pointer_symbol NOT NULL,
  PRIMARY KEY (source_synset_id, target_synset_id)
);
