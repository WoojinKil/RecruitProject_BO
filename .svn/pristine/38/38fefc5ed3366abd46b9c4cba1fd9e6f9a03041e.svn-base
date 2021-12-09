#!/bin/bash
# Start Server Script
CATALINA_HOME='/data/was/tomcat/apache-tomcat-8.5.41'
CONTEXT_PATH='ROOT'
WAR_STAGED_LOCATION="$CATALINA_HOME/webapps/pandora3-0.0.1-SNAPSHOT.war"
# Remove unpacked application artifacts

if [[ -f $CATALINA_HOME/webapps/$CONTEXT_PATH.war ]]; then
    rm $CATALINA_HOME/webapps/$CONTEXT_PATH.war
fi

if [[ -d $CATALINA_HOME/webapps/$CONTEXT_PATH ]]; then
    rm -rfv $CATALINA_HOME/webapps/$CONTEXT_PATH
fi

# Copy the WAR file to the webapps directory
mv $WAR_STAGED_LOCATION $CATALINA_HOME/webapps/$CONTEXT_PATH.war

$CATALINA_HOME/bin/startup.sh