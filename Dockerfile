FROM tomcat:8.5
RUN apt update && apt upgrade -y
RUN mv webapps.dist webapps
ADD **/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD chmod +x /usr/local/tomcat/bin/catalina.sh
CMD ["catalina.sh", "run"]
