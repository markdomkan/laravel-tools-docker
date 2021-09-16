versions=7.2 7.3 7.4

all:
	$(foreach version, $(versions), $(shell docker build --pull --rm -t markdomkan/laravel-tools:php$(version) --build-arg PHP_VERSION=$(version) .))
