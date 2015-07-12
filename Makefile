DICT_TAR = wn3.1.dict.tar.gz
DATABASE = wdpg

SOURCES = $(wildcard sql/??.*.sql)

all: $(SOURCES)
	for source in $(SOURCES); do \
	  psql -X -v ON_ERROR_STOP=true -e -f $$source $(DATABASE); \
	done

dict: $(DICT_TAR)
	tar xf $<

$(DICT_TAR):
	curl -O http://wordnetcode.princeton.edu/$@

clean:
	rm -rf dict $(DICT_TAR)

.PHONY: all clean
