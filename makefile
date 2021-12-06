versions=7.4 8.0 8.1

all:
	$(foreach version, $(versions), $(shell docker buildx build --pull --rm --push --platform linux/amd64,linux/arm64  -t markdomkan/laravel-tools:php$(version) --build-arg PHP_VERSION=$(version) .))
