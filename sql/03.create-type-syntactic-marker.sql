CREATE TYPE syntactic_marker AS ENUM ('p', 'a', 'ip');

CREATE TABLE syntactic_marker_labels (
  syntactic_maker syntactic_marker PRIMARY KEY,
  label text NOT NULL
);

INSERT INTO syntactic_marker_labels (syntactic_maker, label) VALUES
  ('p', 'predicate position'),
  ('a', 'prenominal position'),
  ('ip', 'immediately postnominal position');
