CREATE TABLE synsets (
  id integer PRIMARY KEY,
  lex_filenum integer NOT NULL,
  pos pos NOT NULL,
  word_count integer NOT NULL,
  pointer_count integer NOT NULL,
  frame_count integer,
  glossary text NOT NULL
);
