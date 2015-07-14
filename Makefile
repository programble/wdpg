RUBY = ruby
PSQL = psql

PSQL_FLAGS = -X -v ON_ERROR_STOP=true -e

DICT_TAR = wn3.1.dict.tar.gz
DATABASE = wdpg

PRE = $(wildcard sql/0?.*.sql) $(wildcard sql/1?.*.sql)
DYNAMIC = sql/20.insert-lemmas-noun.sql
DYNAMIC += sql/20.insert-lemmas-verb.sql
DYNAMIC += sql/20.insert-lemmas-adj.sql
DYNAMIC += sql/20.insert-lemmas-adv.sql
DYNAMIC += sql/21.insert-synsets-noun.sql
DYNAMIC += sql/21.insert-synsets-verb.sql
DYNAMIC += sql/21.insert-synsets-adj.sql
DYNAMIC += sql/21.insert-synsets-adv.sql
POST = $(wildcard sql/3?.*.sql)

apply: apply-pre apply-dynamic apply-post

apply-pre: $(PRE)
	set -e; for source in $^; do \
	  $(PSQL) $(PSQL_FLAGS) -f $$source $(DATABASE); \
	done

apply-dynamic: $(DYNAMIC)
	set -e; for source in $^; do \
	  $(PSQL) $(PSQL_FLAGS) -f $$source $(DATABASE); \
	done

apply-post: $(POST)
	set -e; for source in $^; do \
	  $(PSQL) $(PSQL_FLAGS) -f $$source $(DATABASE); \
	done

parse: $(DYNAMIC)

sql/20.insert-lemmas-%.sql: dict/index.%
	$(RUBY) parsers/parse-index.rb $< > $@

sql/21.insert-synsets-%.sql: dict/data.%
	$(RUBY) parsers/parse-data.rb $< > $@

dict/%: dict
	

dict: $(DICT_TAR)
	tar xf $<

$(DICT_TAR):
	curl -O http://wordnetcode.princeton.edu/$@

clean: clean-dynamic clean-dict

clean-dict:
	rm -rf $(DICT_TAR) dict

clean-dynamic:
	rm -f $(DYNAMIC)

.PHONY: apply apply-pre apply-dynamic apply-post parse clean clean-dict clean-dynamic
