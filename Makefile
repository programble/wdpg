DATABASE = wdpg
RUBY = ruby
DICT_TAR = wn3.1.dict.tar.gz

PRE = $(wildcard sql/0?.*.sql) $(wildcard sql/1?.*.sql)
DYNAMIC = sql/20.insert-lemmas-noun.sql
DYNAMIC += sql/20.insert-lemmas-verb.sql
DYNAMIC += sql/20.insert-lemmas-adj.sql
DYNAMIC += sql/20.insert-lemmas-adv.sql
POST = $(wildcard sql/3?.*.sql)

all: $(PRE) $(DYNAMIC) $(POST)
	set -e; for source in $^; do \
	  psql -X -v ON_ERROR_STOP=true -e -f $$source $(DATABASE); \
	done

sql/20.insert-lemmas-%.sql: dict/index.%
	$(RUBY) parsers/parse-index.rb $< > $@

dict/%: dict
	

dict: $(DICT_TAR)
	tar xf $<

$(DICT_TAR):
	curl -O http://wordnetcode.princeton.edu/$@

clean-tar:
	rm -f $(DICT_TAR)

clean-dict:
	rm -rf dict

clean-dynamic:
	rm -f $(DYNAMIC)

clean: clean-dynamic clean-dict clean-tar

.PHONY: all clean-tar clean-dict clean-dynamic clean
