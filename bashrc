
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
	(tmux attach -t 0 || tmux attach || tmux new) && exit
fi

export CONFIG_PATH=$HOME/configs
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export PATH="/usr/local/libexec:${PATH}"
export PATH="/home/neyl/.local/lib/python3.8/site-packages:${PATH}"
export PATH="/home/neyl/.cargo/bin:${PATH}"

if [ $(hostname) = "neyl-VivoBook-ASUSLaptop-X570ZD-X570ZD" ]; then
	source $CONFIG_PATH/computer_dependent/Ubuntu_Laptop.sh
fi

_node_complete() {
  local cur_word options
  cur_word="${COMP_WORDS[COMP_CWORD]}"
  if [[ "${cur_word}" == -* ]] ; then
    COMPREPLY=( $(compgen -W '--enable-source-maps --input-type --http-parser --conditions --experimental-vm-modules --experimental-worker --experimental-import-meta-resolve --experimental-report --experimental-wasi-unstable-preview1 --heapsnapshot-signal --trace-sync-io --print --require --report-on-signal --heap-prof-dir --trace-exit --heapsnapshot-near-heap-limit --inspect-port --stack-trace-limit --prof-process --experimental-repl-await --trace-uncaught --perf-prof-unwinding-info --debug-brk --trace-tls --tls-max-v1.2 --jitless --track-heap-objects --deprecation --inspect-brk-node --interactive --perf-prof --experimental-modules --disallow-code-generation-from-strings --perf-basic-prof-only-functions --huge-max-old-generation-size --trace-deprecation --eval --node-memory-debug --max-old-space-size --redirect-warnings --report-signal --tls-min-v1.0 --insecure-http-parser --tls-keylog --node-snapshot --experimental-specifier-resolution --napi-modules --report-uncaught-exception --cpu-prof-dir --security-revert --experimental-loader --secure-heap --use-largepages --max-http-header-size --warnings --tls-min-v1.1 --use-openssl-ca --tls-cipher-list --interpreted-frames-native-stack --cpu-prof-name --report-filename --experimental-abortcontroller --openssl-config --experimental-policy --icu-data-dir --prof --force-async-hooks-checks --diagnostic-dir --report-on-fatalerror --experimental-json-modules --trace-sigint --enable-fips --debug-arraybuffer-allocations --trace-atomics-wait --abort-on-uncaught-exception --secure-heap-min --trace-event-file-pattern --completion-bash --experimental-top-level-await --use-bundled-ca --zero-fill-buffers --disable-proto --heap-prof-name --frozen-intrinsics --perf-basic-prof --harmony-top-level-await --v8-pool-size --force-fips --trace-event-categories --report-dir --v8-options --preserve-symlinks --test-udp-no-try-send --title --report-compact --trace-warnings --throw-deprecation --version --cpu-prof --verify-base-objects --policy-integrity --debug --inspect-publish-uid --heap-prof --help --heap-prof-interval --cpu-prof-interval --preserve-symlinks-main --tls-min-v1.2 --dns-result-order --pending-deprecation --force-context-aware --expose-internals --unhandled-rejections --experimental-wasm-modules --inspect --check --tls-min-v1.3 --tls-max-v1.3 --inspect-brk --debug-port -i --inspect= --print <arg> --debug= --debug-brk= --inspect-brk= -C -pe --loader --prof-process -c --inspect-brk-node= -e -r --trace-events-enabled -v --security-reverts --es-module-specifier-resolution -h -p --report-directory' -- "${cur_word}") )
    return 0
  else
    COMPREPLY=( $(compgen -f "${cur_word}") )
    return 0
  fi
}
complete -o filenames -o nospace -o bashdefault -F _node_complete node node_g


###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    if ! IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)); then
      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    if ! IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)); then

      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

alias "c"=". ranger"
#alias "norminette"="$HOME/.norminette/norminette.rb"

stty ixon
stty ixany

PS1="\n   \w $> "

#PS1="\033[91;1m[ \033[36;1m\w \033[91;1m] \033[0m"

# vim mode config
# ---------------

set -o vi

# Remove mode switching delay.
# KEYTIMEOUT=5
# 
# # Change cursor shape for different vi modes.
# function zle-keymap-select {
# 	if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
# 		echo -ne '\e[5 q'
# 	elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
# 		make_block
# 	fi
# }
# 
# zle -N zle-keymap-select
# 
# # Use beam shape cursor for each new prompt.
# make_block() {
# 	echo -ne '\e[1 q'
# }
# 
# # Do so now
# make_block
# 
# # And at the start of each prompt
# autoload -U add-zsh-hook
# add-zsh-hook preexec make_block
# 
# 
# bindkey -M viins	" 	" vi-cmd-mode
# bindkey -M visual	" 	" vi-cmd-mode
# bindkey -M viins	-s " " " "
# 
# zle-line-init() { zle -K vicmd; }
# zle -N zle-line-init

export COLUMNS="120"

export PATH="$PATH:/home/neyl/ACLI"
