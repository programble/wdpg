CREATE TYPE pos AS ENUM ('n', 'v', 'a', 's', 'r');

CREATE TABLE pos_labels (
  pos pos PRIMARY KEY,
  label text NOT NULL
);

INSERT INTO pos_labels (pos, label) VALUES
  ('n', 'noun'),
  ('v', 'verb'),
  ('a', 'adjective'),
  ('s', 'adjective satellite'),
  ('r', 'adverb');
