#!/bin/bash

echo "@... dev-ides.sh"

##### IDE ANTIGRAVITY MANAGEMENT #####
function fzl-antigravity-clean-cache(){
    echo "function fzl-antigravity-clean-cache(){..."
}
export -f fzl-antigravity-clean-cache


function fzl-antigravity-start(){
    local antigravity_home="${_ANTIGRAVITY_HOME:-${_PROGSATIVOS_DIR}/ide/antigravity/current}"

    export ANTIGRAVITY_APP_PATH="${ANTIGRAVITY_APP_PATH:-$antigravity_home/antigravity}"
    ANTIGRAVITY_DATA_DIR="${ANTIGRAVITY_DATA_DIR:-$antigravity_home/profile_data}"
    ANTIGRAVITY_EXT_DIR="${ANTIGRAVITY_EXT_DIR:-$antigravity_home/extensions}"

    mkdir -p "$ANTIGRAVITY_DATA_DIR"
    mkdir -p "$ANTIGRAVITY_EXT_DIR"

    "$ANTIGRAVITY_APP_PATH" --user-data-dir "$ANTIGRAVITY_DATA_DIR" --extensions-dir "$ANTIGRAVITY_EXT_DIR" "$@"
}


##### IDE INTELLIJ
function fzl-intellij-start(){
    bash "$_INTELLIJ_HOME/bin/idea.sh"
}
export -f fzl-intellij-start


function _fzl-vscode-home(){
    fzl-first-existing-path \
        "${_VSCODE_HOME:-}" \
        "${VSCODE_EXTERNAL_DISK:-}" \
        "${VSCODE_HOST_DISK:-}"
}


##### IDE VSCODE
function fzl-vscode-setup-chrome-sandbox(){
    local vscode_home
    vscode_home="$(_fzl-vscode-home)"

    if [ -z "$vscode_home" ]; then
        echo "VS Code home not found. Set _VSCODE_HOME or VSCODE_HOST_DISK." >&2
        return 2
    fi

    cd "$vscode_home" || return 1
    sudo chown root:root chrome-sandbox
    sudo chmod 4755 chrome-sandbox
    cd - >/dev/null || return 1
}
export -f fzl-vscode-setup-chrome-sandbox


function fzl-vscode-start(){
    local vscode_home
    vscode_home="$(_fzl-vscode-home)"

    if [ -z "$vscode_home" ]; then
        echo "VS Code home not found. Set _VSCODE_HOME or VSCODE_HOST_DISK." >&2
        return 2
    fi

    cd "$vscode_home" || return 1
    if [ -n "${VSCODE_EXTERNAL_DISK:-}" ] && [ "$vscode_home" = "$VSCODE_EXTERNAL_DISK" ]; then
        ./code "$@" --no-sandbox
    else
        ./code "$@"
    fi
    cd - >/dev/null || return 1
}
export -f fzl-vscode-start


# the theia have appImage.home dir outside of host to make it portable
function fzl-theia-start(){
    local theia_appimage="${_THEIA_APPIMAGE:-${_PROGSATIVOS_DIR}/ide/theia/current/TheiaIDE.AppImage}"

    if [ -d "$theia_appimage" ]; then
        theia_appimage="$theia_appimage/TheiaIDE.AppImage"
    fi

    pgrep -f "TheiaIDE\.AppImage"
    chmod +x "$theia_appimage"
    ls -la "$theia_appimage"
    echo "$@"
    "$theia_appimage" "$@" &
}
export -f fzl-theia-start


#db front ends
function fzl-squirrelsql-start(){
    java -jar "$_SQUIRREL_SQL_HOME/squirrel-sql.jar"
}
export -f fzl-squirrelsql-start


function fzl-dbeaver-start(){
    "$_DBEAVER_HOME/dbeaver" &
}
export -f fzl-dbeaver-start


function fzl-scenebuilder-start(){
    fzl-javafx-scenebuilder-start "$@"
}
