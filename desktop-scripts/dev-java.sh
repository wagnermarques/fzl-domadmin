#!/bin/bash

#JAVA
_ORACLE_JAVA17_HOME=$PROGSATIVOS_DIR/java-jdks/jdk-17.0.3
_ORACLE_JAVA8_HOME=""
_ORACLE_JAVA11_HOME=""
_ORACLE_JAVA21_HOME="$PROGSATIVOS_DIR/java-jdks/jdk-21.0.1"
_ORACLE_JAVA22_HOME=""
_TOMCAT9_HOME="$PROGSATIVOS_DIR/java-servers/apache-tomcat-9.0.84"

export PATH=$JAVA_HOME/bin:$PATH



## COFIGURACOES DE AMBIENTE JAVA
#gradle maveN and ant
export GRADLE_HOME=$PROGSATIVOS_DIR/java-build/gradle-7.4.2
export M2_HOME=$PROGSATIVOS_DIR/java-build/apache-maven-3.8.4
export PATH=$GRADLE_HOME/bin:$M2_HOME/bin:$PATH

function fzl-gradle-setup-7.4.2(){
	export GRADLE_HOME=$PROGSATIVOS_DIR/java-build/gradle-7.4.2
	export PATH=$GRADLE_HOME/bin:$PATH
}
export -f fzl-gradle-setup-7.4.2

# function fzl-java-version-setup(){
# 	if [ "x$1" = "x" ];then
# 	       echo "forneca o parametro 9, 11, 17, 21 ou 22 pra setar a versao do java no terminal";
#         else
# 	    case $1  in 
# 		"8" ) echo 8;;
# 	    "11") echo 11;;
# 		"21") _oracle_java_jdk_21_setup;;
# 		*) echo "forneca como parametro 9, 11, 17, 21 ou 22";;
# 	    esac
# 	fi		
# }
# export -f fzl-java-version-setup


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
