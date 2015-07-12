CREATE TABLE lemmas (
  id serial PRIMARY KEY,
  lemma text NOT NULL,
  pos pos NOT NULL,
  synset_count integer NOT NULL,
  pointer_count integer NOT NULL,
  pointer_types pointer_symbol[] NOT NULL,
  tagsense_count integer NOT NULL,
  UNIQUE (lemma, pos)
);
