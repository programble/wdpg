CREATE TYPE pointer_symbol AS ENUM (
  '!', '@', '@i', '~', '~i', '#m', '#s', '#p', '%m', '%s', '%p', '=', '+', ';',
  '-', ';c', '-c', ';r', '-r', ';u', '-u', '*', '>', '^', '$', '&', '<', '\'
);

CREATE TABLE pointer_symbol_labels (
  pointer_symbol pointer_symbol PRIMARY KEY,
  label text NOT NULL
);

INSERT INTO pointer_symbol_labels (pointer_symbol, label) VALUES
  ('!', 'antonym'),
  ('@', 'hypernym'),
  ('@i', 'instance hypernym'),
  ('~', 'hyponym'),
  ('~i', 'instance hyponym'),
  ('#m', 'member holonym'),
  ('#s', 'substance holonym'),
  ('#p', 'part holonym'),
  ('%m', 'member meronym'),
  ('%s', 'substance meronym'),
  ('%p', 'part meronym'),
  ('=', 'attribute'),
  ('+', 'derivationally related form'),
  (';', 'domain of synset'),
  ('-', 'member of this domain'),
  (';c', 'domain of synset - topic'),
  ('-c', 'member of this domain - topic'),
  (';r', 'domain of synset - region'),
  ('-r', 'member of this domain - region'),
  (';u', 'domain of synset - usage'),
  ('-u', 'member of this domain - usage'),
  ('*', 'entailment'),
  ('>', 'cause'),
  ('^', 'also see'),
  ('$', 'verb group'),
  ('&', 'similar to'),
  ('<', 'participle of verb'),
  ('\', 'pertainym');
