# install the helmchart
template:
	helm template servicename ./helmchart/ -f helmchart/values.dev.yaml
install:
	helm install servicename ./helmchart/ -f helmchart/values.dev.yaml  --create-namespace


create_venv:
ifeq ($(OS),Windows_NT)
	python -m venv venv
	./venv/Scripts/activate && pip install -r servicename/requirements.txt
else
	python3 -m venv venv
	. venv/bin/activate && pip install -r servicename/requirements.txt
endif

run:
ifeq ($(OS),Windows_NT)
	./venv/Scripts/activate && pip install -r servicename/requirements.txt && python servicename/manage.py runserver
else
	. venv/bin/activate && python servicename/manage.py runserver
endif

build:
	docker build -t servicename:latest ./servicename


