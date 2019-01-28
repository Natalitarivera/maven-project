FROM tomcat:8.0

ADD ./webapp/target/*.war /usr/local/tomcat/webapp/

EXPOSE 8080 

CMD [ "/usr/local/tomcat/bin/catalina.sh", "run" ]