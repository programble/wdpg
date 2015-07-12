CREATE TABLE word_words (
  source_word_id integer NOT NULL REFERENCES words,
  target_word_id integer NOT NULL REFERENCES words,
  target_synset_id integer NOT NULL REFERENCES synsets,
  target_pos pos NOT NULL,
  pointer_symbol pointer_symbol NOT NULL,
  PRIMARY KEY (source_word_id, target_word_id)
);
