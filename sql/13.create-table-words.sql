CREATE TABLE words (
  id SERIAL PRIMARY KEY,
  synset_id integer NOT NULL REFERENCES synsets,
  word text NOT NULL,
  syntactic_marker syntactic_marker,
  lex_id integer NOT NULL,
  UNIQUE (word, syntactic_marker, lex_id)
);
