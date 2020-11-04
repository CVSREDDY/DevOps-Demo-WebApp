FROM tomcat:8.5
RUN apt update && apt upgrade -y
COPY webapps.dist/ webapps/
RUN ls -ltr webapps/
ADD **/*.war /usr/local/tomcat/webapps/
RUN ls -ltr webapps/
EXPOSE 8080
CMD chmod +x /usr/local/tomcat/bin/catalina.sh
CMD ["catalina.sh", "run"]
