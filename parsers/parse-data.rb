#!/usr/bin/env ruby

ARGF.each_line do |line|
  next if line.start_with? '  '
  split = line.split ' | '
  columns = split[0].split ' '
  gloss = split[1].strip.gsub /'/, "''"

  synset_offset = columns.shift
  lex_filenum = columns.shift.to_i
  pos = columns.shift
  pos = 'a' if pos == 's'
  word_count = columns.shift.to_i 16

  words = []
  word_count.times do
    word = columns.shift
    word.gsub! /_/, ' '
    word.gsub! /'/, "''"
    lex_id = columns.shift.to_i 16
    syntactic_marker = 'NULL'

    word.match /^([^(]+)(\(([a-z]+)\))?$/ do |m|
      if m[3]
        word = m[1]
        syntactic_marker = "'#{m[3]}'"
      end
    end

    words << [word, syntactic_marker, lex_id]
  end

  pointer_count = columns.shift.to_i
  pointers = []
  pointer_count.times do
    pointer_symbol = columns.shift.gsub /\\/, '\\\\'
    target_offset = columns.shift
    target_pos = columns.shift

    wst = columns.shift
    source_word = wst[0, 2].to_i 16
    target_word = wst[2, 2].to_i 16

    pointers << [pointer_symbol, target_offset, target_pos, source_word, target_word]
  end
  synset_pointers, word_pointers = pointers.uniq.partition {|p| p[3] == 0 }

  # TODO: Frames

  puts <<-EOF
WITH synset AS (
  INSERT INTO synsets
  (id, lex_filenum, pos, word_count, pointer_count, glossary)
  VALUES (
    '#{pos}#{synset_offset}', #{lex_filenum}, '#{pos}', #{word_count},
    #{pointer_count}, '#{gloss}'
  )
  RETURNING id
), synset_words AS (
  INSERT INTO words (synset_id, word, syntactic_marker, lex_id, word_number)
  VALUES
  EOF
  values = words.map.with_index do |w, i|
    "('#{pos}#{synset_offset}', '#{w[0]}', #{w[1]}, #{w[2]}, #{i+1})"
  end.join ', '
  puts '    ' + values
  puts <<-EOF
  RETURNING id, word_number
)
  EOF
  if synset_pointers.any?
    puts <<-EOF
, synset_pointers AS (
  INSERT INTO synset_synsets
  (source_synset_id, target_synset_id, target_pos, pointer_symbol)
  VALUES
    EOF
    values = synset_pointers.map.with_index do |p, i|
      "('#{pos}#{synset_offset}', '#{p[2]}#{p[1]}', '#{p[2]}', '#{p[0]}')"
    end.join ', '
    puts '    ' + values
    puts ")"
  end
  if word_pointers.any?
    puts <<-EOF
, word_pointers_raw (ps, tsi, tpos, swn, twn) AS (
  VALUES
    EOF
    values = word_pointers.map do |ps, to, tpos, swn, twn|
      "('#{ps}', '#{tpos}#{to}', '#{tpos}', #{swn}, #{twn})"
    end.join ', '
    puts '    ' + values
    puts <<-EOF
)
INSERT INTO word_words
(source_word_id, target_synset_id, target_pos, target_word_number, pointer_symbol)
SELECT synset_words.id, w.tsi, w.tpos::pos, w.twn, w.ps::pointer_symbol
FROM word_pointers_raw w, synset_words
WHERE synset_words.word_number = w.swn;
    EOF
  else
    puts "SELECT NULL;"
  end

  puts
end
