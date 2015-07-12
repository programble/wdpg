CREATE TABLE word_words (
  source_word_id integer PRIMARY KEY REFERENCES words,
  target_synset_id text NOT NULL,
  target_pos pos NOT NULL,
  target_word_number integer NOT NULL,
  pointer_symbol pointer_symbol NOT NULL
);
