CREATE TABLE synsets (
  id text PRIMARY KEY,
  lex_filenum integer NOT NULL,
  pos pos NOT NULL,
  word_count integer NOT NULL,
  pointer_count integer NOT NULL,
  glossary text NOT NULL
);
