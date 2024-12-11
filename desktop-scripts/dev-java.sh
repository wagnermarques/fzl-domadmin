#!/bin/bash

echo ### dev-java.sh running...
THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"



#JAVA ON DOCKER
_JAVA_DOCKER_JDK_IMG=eclipse-temurin:21-jdk-alpine
_JAVA_DOCKER_MVN_IMG="maven:3.9.5-eclipse-temurin-21-alpine"
_M2_REPO="$THIS_SCRIPT_DIR/../desktop-vars/m2-repo"

function fzl-java(){
	docker run -it --rm \
		-v $(pwd):/app \
		-w /app \
		$_JAVA_DOCKER_JDK_IMG java "$@"
}
export -f fzl-java



#JAVA JDK ON DESKTOP HOST
_ORACLE_JAVA8_HOME=""
_ORACLE_JAVA11_HOME=""
_ORACLE_JAVA17_HOME="$PROGSATIVOS_DIR/java-jdks/jdk-17.0.3"
_ORACLE_JAVA21_HOME="$PROGSATIVOS_DIR/java-jdks/jdk-21.0.1"
_ORACLE_JAVA22_HOME=""

JAVA_HOME=$_ORACLE_JAVA21_HOME
export PATH=$JAVA_HOME/bin:$PATH

function _oracle_java_jdk_21_setup(){
	export JAVA_HOME=$_ORACLE_JAVA21_HOME
	export PATH=$JAVA_HOME/bin:$PATH
}

function _oracle_java_jdk_17_setup(){
	export JAVA_HOME=$_ORACLE_JAVA17_HOME
	export PATH=$JAVA_HOME/bin:$PATH
}


function fzl-java-setup--oracle-jdk-17(){
	export JAVA_HOME=$_ORACLE_JAVA17_HOME
	export PATH=$JAVA_HOME/bin:$PATH
}
export -f fzl-java-setup--oracle-jdk-17


function fzl-java-setup--oracle-jdk-21(){
	export JAVA_HOME=$_ORACLE_JAVA21_HOME
	export PATH=$JAVA_HOME/bin:$PATH
}
export -f fzl-java-setup--oracle-jdk-21



function fzl-java-version-setup(){
	if [ "x$1" = "x" ];then
	       echo "forneca o parametro 9, 11, 17, 21 ou 22 pra setar a versao do java no terminal";
        else
	    case $1  in 
		"8" ) echo 8;;
	    "11") echo 11;;
		"17") _oracle_java_jdk_17_setup;;
		"21") _oracle_java_jdk_21_setup;;
 		*) echo "forneca como parametro 9, 11, 17, 21 ou 22";;
	    esac
	fi		
}
export -f fzl-java-version-setup


#JAVA BUILD TOOLS ON DOCKER
function fzl-mvn(){
	#https://hub.docker.com/_/maven
	docker run -it --rm \
        -v $_M2_REPO:/root/.m2 \
        -v $(pwd):/app \
        -w /app \
        $_JAVA_DOCKER_MVN_IMG mvn "$@"
}
export -f fzl-mvn



#JAVA BUILD TOOLS ON DESKTOP HOST 
export _GRADLE_HOME_7_4_2=$PROGSATIVOS_DIR/java-build/gradle-7.4.2
export _GRADLE_HOME_8_11_1=$PROGSATIVOS_DIR/java-build/gradle-8.11.1
export M2_HOME=$PROGSATIVOS_DIR/java-build/apache-maven-3.8.4


function fzl-gradle-setup-7.4.2(){
	export GRADLE_HOME=$_GRADLE_HOME_7_4_2
	export PATH=$GRADLE_HOME/bin:$PATH
	gradle -v
}
export -f fzl-gradle-setup-7.4.2	


function fzl-gradle-setup-8.11.1(){
	export GRADLE_HOME=$_GRADLE_HOME_8_11_1
	export PATH=$GRADLE_HOME/bin:$PATH
	gradle -v
}
export -f fzl-gradle-setup-8.11.1



#JAVA SERVERS ON DESKTOP HOST
_TOMCAT9_HOME="$PROGSATIVOS_DIR/java-servers/apache-tomcat-9.0.84"

function fzl-tomcat9-start(){
	$_TOMCAT9_HOME/bin/startup.sh
}
function fzl-tomcat9-stop(){
	$_TOMCAT9_HOME/bin/shutdown.sh
}
export -f fzl-tomcat9-start	
export -f fzl-tomcat9-stop

