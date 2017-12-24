SOURCES = bin/maid bin/serv bin/pass bin/mktex bin/theme

.PHONY: all
all: $(SOURCES)

.PHONY: production
production: FLAGS = --release
production: $(SOURCES)

.PHONY: update
update:
	shards update

.PHONY: install
install:
	shards install

bin/maid: src/maid.cr
	crystal build $^ -o $@ $(FLAGS)

bin/serv: src/serv.cr
	crystal build $^ -o $@ $(FLAGS)

bin/pass: src/pass.cr
	crystal build $^ -o $@ $(FLAGS)

bin/mktex: src/mktex.cr
	crystal build $^ -o $@ $(FLAGS)

bin/theme: src/theme.cr lib/theme.cr
	crystal build $< -o $@ $(FLAGS)
