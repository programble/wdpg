ALTER TABLE synset_synsets
  ADD FOREIGN KEY (target_synset_id) REFERENCES synsets;
