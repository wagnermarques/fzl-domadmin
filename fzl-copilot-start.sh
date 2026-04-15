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
  if [ "$#" -lt 1 ]; then
    echo "Usage: fzl-copilot-start \"Question\" [subagent_paths...]" >&2
    return 2
  fi
  local question="$1"; shift
  local tmpfile
  tmpfile=$(mktemp)
  # prefer repo-local ai-agents folder, then user config, then fallback to org source
  if [ -f "./ai-agents/fzl-emacs-agent/txts/fzl-emacs.txt" ]; then
    cat "./ai-agents/fzl-emacs-agent/txts/fzl-emacs.txt" > "$tmpfile"
  elif [ -f "$HOME/.config/copilot/agents/fzl-emacs.txt" ]; then
    cat "$HOME/.config/copilot/agents/fzl-emacs.txt" > "$tmpfile"
  elif [ -f "./ai-agents/fzl-emacs-agent/orgfiles/fzl-emacs-agent.org" ]; then
    # extract plain block if present (from new orgfiles location)
    awk '/^#\+begin_src text/,/^#\+end_src/{if($0!="#\+begin_src text" && $0!="#\+end_src")print}' ./ai-agents/fzl-emacs-agent/orgfiles/fzl-emacs-agent.org > "$tmpfile"
  elif [ -f "./fzl-emacs-agent.org" ]; then
    # extract plain block if present (fallback to legacy location)
    awk '/^#\+begin_src text/,/^#\+end_src/{if($0!="#\+begin_src text" && $0!="#\+end_src")print}' ./fzl-emacs-agent.org > "$tmpfile"
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
  # call copilot CLI: pass agent prompt as first argument and question as second
  copilot "$(cat "$tmpfile")" "$question"
  rm -f "$tmpfile"
}

# Optional: add to shell rc
# echo "source /path/to/fzl-copilot-start.sh" >> ~/.bashrc
