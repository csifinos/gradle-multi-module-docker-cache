FROM adoptopenjdk/openjdk11 as builder

WORKDIR /home/app

COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

FROM adoptopenjdk/openjdk11 as module1

WORKDIR /home/app

COPY --from=builder /home/app .
RUN ["/bin/bash", "-c", "./gradlew --version"]
COPY module1/src module1/src
RUN ["/bin/bash", "-c", "./gradlew :module1:build"]

FROM adoptopenjdk/openjdk11 as module2

WORKDIR /home/app

COPY --from=builder /home/app .
RUN ["/bin/bash", "-c", "./gradlew --version"]
COPY module2/src module2/src
RUN ["/bin/bash", "-c", "./gradlew :module2:build"]

FROM adoptopenjdk/openjdk11 as final

WORKDIR /home/app
COPY --from=module1 /home/app/module1/build module1/build
COPY --from=module2 /home/app/module2/build module2/build
