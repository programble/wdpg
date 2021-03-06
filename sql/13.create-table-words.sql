CREATE TABLE words (
  id SERIAL PRIMARY KEY,
  synset_id text NOT NULL REFERENCES synsets,
  word text NOT NULL,
  syntactic_marker syntactic_marker,
  lex_id integer NOT NULL,
  word_number integer NOT NULL,
  UNIQUE (synset_id, word_number)
);
