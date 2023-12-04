# 기본 이미지로부터 시작합니다. 여기서는 OpenJDK 8과 Maven을 설치한 이미지를 사용합니다.
FROM maven:3.6.3-jdk-11

# 작업 디렉토리를 설정합니다.
WORKDIR /usr/src/app

# 소스 코드를 현재 디렉토리로 복사합니다.
COPY . .

# Maven을 사용하여 프로젝트를 빌드합니다.
RUN mvn clean package

# Tomcat을 설치합니다. 여기서는 Tomcat 9를 사용합니다.
FROM tomcat:9.0-jdk11-corretto

# 빌드된 WAR 파일을 Tomcat의 webapps 디렉토리로 복사합니다.
COPY target/jenkins.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat을 실행합니다.
CMD ["catalina.sh", "run"]