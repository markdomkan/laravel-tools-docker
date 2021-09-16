versions=7.4 8.0

all:
	$(foreach version, $(versions), $(shell docker build --pull --rm -t markdomkan/laravel-tools:php$(version) --build-arg PHP_VERSION=$(version) .))
