#!/usr/bin/env bash
# fzl-copilot-start.sh - helper to run copilot CLI with fzl agents
# Usage:
#   source ./fzl-copilot-start.sh
#   fzl-copilot-start "Describe org-babel workflow" [subagent1.txt subagent2.txt]

fzl-copilot-start(){
  if ! command -v copilot >/dev/null 2>&1; then
    echo "copilot CLI not found in PATH. Install or use the full path." >&2
    return 2
  fi

  # Parse optional flags: -c|--config config_file, -l|--log log_file
  local config_file=""
  local log_file=""
  while [ $# -gt 0 ]; do
    case "$1" in
      -c|--config)
        config_file="$2"
        shift 2
        ;;
      -l|--log)
        log_file="$2"
        shift 2
        ;;
      --help|-h)
        echo "Usage: fzl-copilot-start [-c config_file] [-l log_file] \"Question\" [subagent_paths...]"
        return 0
        ;;
      *)
        break
        ;;
    esac
  done

  if [ "$#" -lt 1 ]; then
    echo "Usage: fzl-copilot-start [-c config_file] [-l log_file] \"Question\" [subagent_paths...]" >&2
    return 2
  fi

  local question="$1"; shift

  local tmpfile
  tmpfile=$(mktemp) || { echo "Failed to create temp file" >&2; return 2; }
  # ensure tmpfile removed on function exit
  trap 'rm -f "'$tmpfile'"' RETURN

  local agent_src=""
  # prefer repo-local ai-agents folder, then user config, then fallback to org source
  if [ -n "$config_file" ] && [ -f "$config_file" ]; then
    cat "$config_file" > "$tmpfile"
    agent_src="$config_file"
  elif [ -f "./ai-agents/fzl-emacs-agent/txts/fzl-emacs.txt" ]; then
    cat "./ai-agents/fzl-emacs-agent/txts/fzl-emacs.txt" > "$tmpfile"
    agent_src="./ai-agents/fzl-emacs-agent/txts/fzl-emacs.txt"
  elif [ -f "$HOME/.config/copilot/agents/fzl-emacs.txt" ]; then
    cat "$HOME/.config/copilot/agents/fzl-emacs.txt" > "$tmpfile"
    agent_src="$HOME/.config/copilot/agents/fzl-emacs.txt"
  elif [ -f "./ai-agents/fzl-emacs-agent/orgfiles/fzl-emacs-agent.org" ]; then
    # extract plain block if present (from new orgfiles location)
    awk '/^#\+begin_src text/,/^#\+end_src/{if($0!="#\+begin_src text" && $0!="#\+end_src")print}' ./ai-agents/fzl-emacs-agent/orgfiles/fzl-emacs-agent.org > "$tmpfile"
    agent_src="./ai-agents/fzl-emacs-agent/orgfiles/fzl-emacs-agent.org"
  elif [ -f "./fzl-emacs-agent.org" ]; then
    # extract plain block if present (fallback to legacy location)
    awk '/^#\+begin_src text/,/^#\+end_src/{if($0!="#\+begin_src text" && $0!="#\+end_src")print}' ./fzl-emacs-agent.org > "$tmpfile"
    agent_src="./fzl-emacs-agent.org"
  fi

  # append any subagents specified (prefer repo ai-agents, then user config)
  for sa in "$@"; do
    if [ -f "./ai-agents/fzl-emacs-agent/txts/subagents/$sa" ]; then
      cat "./ai-agents/fzl-emacs-agent/txts/subagents/$sa" >> "$tmpfile"
    elif [ -f "$HOME/.config/copilot/agents/subagents/$sa" ]; then
      cat "$HOME/.config/copilot/agents/subagents/$sa" >> "$tmpfile"
    elif [ -f "$sa" ]; then
      cat "$sa" >> "$tmpfile"
    fi
  done

  # prepare log location
  local log_dir="${FZL_COPILOT_LOGDIR:-$HOME/.cache/fzl}"
  mkdir -p "$log_dir"
  if [ -n "$log_file" ]; then
    :
  else
    log_file="${FZL_COPILOT_LOG:-$log_dir/fzl-copilot-start-$(date +%Y%m%d-%H%M%S).log}"
  fi

  {
    echo "==== fzl-copilot-start: $(date --iso-8601=seconds) ===="
    echo "Question: $question"
    echo "Agent source: ${agent_src:-<none>}"
    echo "Tempfile: $tmpfile"
    echo "Args: $*"
  } >> "$log_file"

  # run copilot, tee stdout/stderr to terminal and log file
  copilot "$(cat "$tmpfile")" "$question" > >(tee -a "$log_file") 2> >(tee -a "$log_file" >&2)
  local exitcode=$?

  echo "==== fzl-copilot-start exit: $(date --iso-8601=seconds) code=$exitcode ====" >> "$log_file"

  return $exitcode
}
export -f fzl-copilot-start


# Optional: add to shell rc
# echo "source /path/to/fzl-copilot-start.sh" >> ~/.bashrc
