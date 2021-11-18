FROM abdelrazekrizk/tomcat-p-9090:8
LABEL app=my-app
COPY target/*.war /usr/local/tomcat/webapps/myweb.war
