FROM tomcat:latest
LABEL app=my-app
COPY target/*.war /usr/local/tomcat/webapps/myweb.war
