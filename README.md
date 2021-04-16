## Building And Run

Building the image

    ./gradlew jibDockerBuild

Start and connect to the container

    docker run -ti --rm jib/gradle-multi-module-docker-cache
