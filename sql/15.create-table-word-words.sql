CREATE TABLE word_words (
  source_word_id integer NOT NULL REFERENCES words,
  pointer_symbol pointer_symbol NOT NULL,
  target_synset_id text NOT NULL,
  target_pos pos NOT NULL,
  target_word_number integer NOT NULL,
  PRIMARY KEY (source_word_id, pointer_symbol, target_synset_id, target_word_number)
);
