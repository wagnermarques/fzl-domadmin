function fzl-ambiente-dev-php-fpm-moodle-joomla--up() {
    local PROJ_HOME=/run/media/wgn/5E42523D579ED654/Ambiente-Dev--php-fpm-Apache2-Moodle-Joomla
    cd $PROJ_HOME
    ansible-playbook ./build-containers/with-ansible/playbook-containers-run.yml --ask-become-pass
}
export -f fzl-ambiente-dev-php-fpm-moodle-joomla

function fzl-ambiente-dev-php-fpm-moodle-joomla--install-applications-moodle() {
    local PROJ_HOME=/run/media/wgn/5E42523D579ED654/Ambiente-Dev--php-fpm-Apache2-Moodle-Joomla
    cd $PROJ_HOME
    ansible-playbook ./install-applications/install-moodle/playbook-moodle-installation-dev.yml --ask-become-pass
}
export -f fzl-ambiente-dev-php-fpm-moodle-joomla--install-applications-moodle


function fzl-ambiente-dev-php-fpm-moodle-joomla--install-applications-joomla() {
    local PROJ_HOME=/run/media/wgn/5E42523D579ED654/Ambiente-Dev--php-fpm-Apache2-Moodle-Joomla
    cd $PROJ_HOME
    ansible-playbook ./install-applications/install-joomla/playbook-joomla-installation-dev.yml --ask-become-pass
}
export -f fzl-ambiente-dev-php-fpm-moodle-joomla--install-applications-joomla

function fzl-ambiente-dev-php-fpm-moodle-joomla--diag() {
    echo "==> docker exec -it phpdev-apache2-php7-dev ls -la /var/www"
    docker exec -it phpdev-apache2-php7-dev ls -la /var/www
    echo .
    echo "==> docker exec -it phpdev-php-fpm8-dev php -v"
    docker exec -it phpdev-php-fpm8-dev php -v
}


#access moodle
function fzl-ambiente-dev-php-fpm-moodle-joomla--access-moodle() {
    xdg-open http://localhost:7777/MOODLE_404_STABLE/
}
export -f fzl-ambiente-dev-php-fpm-moodle-joomla--access-moodle

#access phpmyadmin
function fzl-ambiente-dev-php-fpm-moodle-joomla--access-phpmyadmin() {
    xdg-open http://localhost:9090/
}
export -f fzl-ambiente-dev-php-fpm-moodle-joomla--access-phpmyadmin