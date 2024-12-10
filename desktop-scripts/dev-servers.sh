#server
function fzl-tomcat9-start(){
	bash "$PROGSATIVOS_DIR/java-servers/apache-tomcat-9.0.84/bin/startup.sh" &
	echo "$PROGSATIVOS_DIR/java-servers/apache-tomcat-9.0.84/bin/startup.sh" 
        tail -f "$PROGSATIVOS_DIR/java-servers/apache-tomcat-9.0.84/bin/startup.sh" 
}

export -f fzl-tomcat9-start