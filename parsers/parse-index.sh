#!/bin/bash

set -e

while read -r -a line; do
  lemma=${line[0]//_/ }
  echo "WITH lemma AS ("
  echo "  INSERT INTO lemmas"
  echo "  (lemma, pos, synset_count, pointer_count, pointer_types, tagsense_count)"
  echo "  VALUES ("
  echo "    '${lemma//\'/''}', '${line[1]}', ${line[2]}, ${line[3]},"
  if [ ${line[3]} -ne 0 ]; then
    echo -n "    '{\""
    pointer_types=${line[*]:4:${line[3]}}
    pointer_types=${pointer_types//\\/\\\\}
    echo -n "${pointer_types// /\",\"}"
    echo "\"}',"
  else
    echo "    '{}',"
  fi
  echo "    ${line[4 + ${line[3]}]}"
  echo "  )"
  echo "  RETURNING id"
  echo "),"

  echo "senses(synset_id, sense_number) AS ("
  echo "  VALUES"
  senses=("${line[@]:6+${line[3]}}")
  rows=()
  for i in $(seq 0 $(( ${#senses[@]} - 1)) ); do
    rows+=("(${senses[i]}, $((i+1)))")
  done
  _ifs=$IFS
  IFS=,
  echo -n "  ${rows[*]}"
  IFS=$_ifs
  echo
  echo ")"

  echo "INSERT INTO lemma_synsets (lemma_id, synset_id, sense_number)"
  echo "SELECT lemma.id, senses.synset_id, senses.sense_number"
  echo "FROM lemma, senses;"

  echo
done
