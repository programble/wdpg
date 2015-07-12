#!/usr/bin/env ruby

ARGF.each_line do |line|
  next if line.start_with? '  '
  columns = line.split ' '

  lemma = columns.shift
  lemma.gsub! /_/, ' '
  lemma.gsub! /'/, "''"

  pos = columns.shift
  synset_count = columns.shift
  pointer_count = columns.shift

  pointer_types = columns.slice! 0, pointer_count.to_i
  pointer_types.map! do |type|
    type.gsub(/\\/, '\\\\').inspect
  end

  columns.shift # sense_cnt
  tagsense_count = columns.shift

  synset_ids = columns
  senses = synset_ids.map.with_index do |synset_id, i|
    "(#{synset_id}, #{i + 1})"
  end

  puts <<-EOF
WITH lemma AS (
  INSERT INTO lemmas
  (lemma, pos, synset_count, pointer_count, pointer_types, tagsense_count)
  VALUES (
    '#{lemma}', '#{pos}', #{synset_count}, #{pointer_count},
    '{#{pointer_types.join(',')}}', #{tagsense_count}
  )
  RETURNING id
), senses (synset_id, sense_number) AS (
  VALUES #{senses.join(', ')}
)
INSERT INTO lemma_synsets (lemma_id, synset_id, sense_number)
SELECT lemma.id, senses.synset_id, senses.sense_number
FROM lemma, senses;

  EOF
end
