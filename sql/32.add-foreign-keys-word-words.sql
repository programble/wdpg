ALTER TABLE word_words
  ADD FOREIGN KEY (target_synset_id) REFERENCES synsets,
  ADD FOREIGN KEY (target_synset_id, target_word_number)
    REFERENCES words (synset_id, word_number);
