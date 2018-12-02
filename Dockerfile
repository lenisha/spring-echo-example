FROM gradle:4.10-jdk11-slim as builder
COPY --chown=gradle:gradle . /home/gradle
WORKDIR /home/gradle
USER gradle              
RUN	gradle clean assemble

FROM openjdk:8-alpine
WORKDIR /home/
COPY --from=builder /home/gradle/build/libs/*.jar /home/
EXPOSE 8080
ENTRYPOINT [ "java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-jar", "/home/spring-echo-example-1.0.0.jar" ]
