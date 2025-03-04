gitea:
	docker-compose -f provision/compose/docker-compose-gitea.yaml up -d
jenkins:
	docker-compose -f provision/compose/docker-compose-jenkins.yaml up -d
k3s:
	docker-compose -f provision/compose/docker-compose-k3s.yaml up -d
nexus:
	docker-compose -f provision/compose/docker-compose-nexus.yaml up -d
sonar:
	docker-compose -f provision/compose/docker-compose-sonar.yaml up -d
nginx:
	docker-compose -f provision/compose/docker-compose-nginx.yaml up -d




.PHONY: gitea jenkins k3s nexus sonar nginx 