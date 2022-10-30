FROM  tomcat:9.0.8-jre8-alpine
LABEL version="1.0"
LABEL maintainer="abcorg.com"
COPY target/*.war /usr/local/tomcat/webapps/abcorg.war
EXPOSE 8080
CMD ["catalina.sh", "run"]


