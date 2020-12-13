FROM tomcat:8.0-alpine
LABEL maintainer="Miguel Ramirez Olmos"

COPY dist/FinalWeb.war /usr/local/tomcat/webapps/FinalWeb.war

EXPOSE 8080
CMD ["catalina.sh", "run"]