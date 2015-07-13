CREATE TABLE synset_synsets (
  source_synset_id text NOT NULL REFERENCES synsets,
  pointer_symbol pointer_symbol NOT NULL,
  target_synset_id text NOT NULL,
  target_pos pos NOT NULL,
  PRIMARY KEY (source_synset_id, pointer_symbol, target_synset_id)
);
