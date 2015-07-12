CREATE TABLE lemma_synsets (
  lemma_id integer NOT NULL REFERENCES lemmas,
  synset_id integer NOT NULL,
  sense_number integer NOT NULL,
  PRIMARY KEY (lemma_id, synset_id)
);
