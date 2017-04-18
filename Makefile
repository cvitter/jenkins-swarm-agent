include .env

default:

# build-java-agent:
# 	Builds a docker image using Dockerfile.java-swarm-agent
#	with Java JDK, Maven, Git, and Docker installed
build-java-agent:
	docker build --rm \
	-f dockerfiles/Dockerfile.java-swarm-agent \
	-t java-swarm-agent .

# run-java-agent
#	Runs the docker image created in build-java-agent above.
#	Passes 4 optional parameters imported from the .env file
run-java-agent:
	docker run -d \
	--network=$(SWARM_NETWORK) \
	--volume /var/run/docker.sock:/var/run/docker.sock \
	java-swarm-agent \
	java -jar swarm-client-3.3.jar \
	-master $(SWARM_MASTER) \
	-username $(SWARM_USER) \
	-password $(SWARM_PASS) \
	-executors 1 \


# stop-java-agents
#	Stops all instances of the java-swarm-agent image that are running
stop-java-agents:
	docker stop $$(docker ps -q --filter ancestor="java-swarm-agent")
