DATABASE = wdpg
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
	tail -n +30 $< | bash parsers/parse-index.sh > $@

dict/%: dict
	

dict: $(DICT_TAR)
	tar xf $<

$(DICT_TAR):
	curl -O http://wordnetcode.princeton.edu/$@

clean:
	rm -rf dict $(DICT_TAR) $(DYNAMIC)

.PHONY: all clean
