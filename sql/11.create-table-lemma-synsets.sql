CREATE TABLE lemma_synsets (
  lemma_id integer PRIMARY KEY REFERENCES lemmas,
  synset_id text NOT NULL,
  sense_number integer NOT NULL
);
