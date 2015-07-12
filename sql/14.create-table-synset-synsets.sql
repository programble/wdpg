CREATE TABLE synset_synsets (
  source_synset_id text PRIMARY KEY REFERENCES synsets,
  target_synset_id text NOT NULL,
  target_pos pos NOT NULL,
  pointer_symbol pointer_symbol NOT NULL
);
