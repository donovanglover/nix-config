SOURCES = bin/maid bin/serv bin/pass bin/theme
BIN = bin/

.PHONY: all
all: $(SOURCES)

.PHONY: release
production: FLAGS = --release
production: $(SOURCES)

.PHONY: update
update:
	shards update

.PHONY: install
install:
	shards install

bin/maid: src/maid.cr
	@mkdir -p ${BIN}
	crystal build $< -o $@ $(FLAGS)

bin/pass: src/pass.cr
	@mkdir -p ${BIN}
	crystal build $< -o $@ $(FLAGS)

bin/theme: src/theme.cr src/theme_helper/*.cr
	@mkdir -p ${BIN}
	crystal build $< -o $@ $(FLAGS)

bin/trufetch: src/trufetch.cr
	@mkdir -p ${BIN}
	crystal build $< -o $@ $(FLAGS)

bin/git-blame: src/git-blame.cr
	@mkdir -p ${BIN}
	crystal build $< -o $@ ${FLAGS}

bin/plain-text: src/plain-text.cr
	@mkdir -p ${BIN}
	crystal build $< -o $@ ${FLAGS}
