versions=7.4 8.0

all:
	$(foreach version, $(versions), $(shell docker build --pull --rm -t markdomkan/laravel-tools:php$(version) --build-arg PHP_VERSION=$(version) .))
	$(foreach version, $(versions), $(shell docker build --pull --rm --platform linux/arm64 -t markdomkan/laravel-tools:php$(version)-arm64 --build-arg PHP_VERSION=$(version) .))
