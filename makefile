.PHONY: help clean requirements build

help:
	@cat makefile

clean:
	@rm -fr .venv dist build

.venv:
	@python3.11 -m ensurepip
	@python3.11 -m pip install --upgrade pip
	@python3.11 -m pip install --upgrade virtualenv
	@python3.11 -m virtualenv .venv

requirements: .venv
	@.venv/bin/pip3 install --upgrade pip -r requirements.txt

test: requirements
	@.venv/bin/pytest --cov --cov-branch --cov-report term-missing

build: requirements
	@rm -fr dist build
	@.venv/bin/python -m build

test-deploy: build
	@.venv/bin/python -m twine upload --repository testpypi dist/*

deploy: build
	@.venv/bin/python -m twine upload dist/*

run: requirements
	python3 -m docman

tag:
	git tag -a 0.0.4 -m 'Added several new commands and functionality'
