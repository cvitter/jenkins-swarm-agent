# Jenkins Swarm Agents - Examples

Jenkins Swarm agents are stand alone clients that can auto-discover a Jenkins (http://jenkins.io) master and add resources to the master "auto-magically". This repository is intended to provide examples of how to build Docker based swarm agents. The first example added creates an agent that can [perform Java/Maven builds](#javamaven-agent-example). I will add additional examples in the future as time allows.

**Note**: In order to use swarm agents with Jenkins you need to install the Swarm Plugin (https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin) on your Jenkins masters.

# Java/Maven Agent Example

The Java/Maven agent [Dockerfile.java-swarm-agent](dockerfiles/Dockerfile.java-swarm-agent) creates an Alpine Linux (https://alpinelinux.org/) based docker image with the following components installed on it:

* Java OpenJDK 8
* Maven 3
* Curl
* Git
* Docker
* The Jenkins Swarm CLI Client

### Jenkins Configuration

In addition to installing the Swarm Plugin (https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin) on your Jenkins masters you need to configure the master to use tools on the agent. The Java home, for example, on the swarm agent is in the /usr/bin/java directory (a standard location for default Java installs on most unix flavors but not where Jenkins installs Java if you do the automatic install). If the master uses a different Java home you will need to add an additional JDK Installation under **Manage Jenkins \ Global Tool Configuration**.

**Note**: In addition to updating the master's Global Tool Configuration you will need to make sure that your jobs are configured to use the tools that are configured on the swarm agent.

### Configuring the Agent

The Java agent example has four configurable settings that you will need to update for your environment. These settings get loaded from the [.env](.env) file when you run the agent from the project's [Makefile](Makefile). The four settings are:

* **SWARM_NETWORK** - Optional, the SWARM_NETWORK setting tells Docker which Docker network the container should connect too when it starts up (see the following documentation for more details: https://docs.docker.com/engine/reference/commandline/network_connect/).

* **SWARM_MASTER** - Optional, the SWARM_MASTER parameter tells the CLI Agent which Jenkins master to connect to (must be specified with full URL, e.g.: http://server:8080/jenkins/). If the parameter isn't set the CLI will attempt to auto-discover a master on the local network.

* **SWARM_USER** - Optional, The Jenkins user name to authenticate with.
* **SWARM_PASS** - Optional, The Jenkins password to authenticate with.

**Note**: The CLI Agent has many additional optional parameters that can be set. Please see the plugin documentation (https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin) for a complete reference. If you choose to add parameters when launching the CLI agent you will need to modify the .env file and the **run-java-agent** section of the Makefile to use the added parameters.


### Building and Running the Agent

 