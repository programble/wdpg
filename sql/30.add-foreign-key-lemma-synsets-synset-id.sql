ALTER TABLE lemma_synsets
  ADD FOREIGN KEY (synset_id) REFERENCES synsets;
