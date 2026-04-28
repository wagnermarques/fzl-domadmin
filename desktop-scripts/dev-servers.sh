#server
function fzl-tomcat9-start(){
	local tomcat_home="${_TOMCAT9_HOME:-$PROGSATIVOS_DIR/java/servers/tomcat9/current}"

	bash "$tomcat_home/bin/startup.sh" &
	echo "$tomcat_home/bin/startup.sh"
        tail -f "$tomcat_home/logs/catalina.out"
}

export -f fzl-tomcat9-start
