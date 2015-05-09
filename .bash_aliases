# If these are enabled they will be used instead of any instructions
# they may mask. For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Misc :)
alias vi='vim'                                # proxy vi to vim
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color=auto'                # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty --ignore="\$Recycle.Bin" --ignore="\$RECYCLE.BIN" --ignore="System Volume Information" --ignore="ntuser*" --ignore="NTUSER*"'
alias dir='ls -hF --format=vertical --color=tty --ignore="\$Recycle.Bin" --ignore="\$RECYCLE.BIN" --ignore="System Volume Information" --ignore="ntuser*" --ignore="NTUSER*"'
alias vdir='ls -hF --format=long --color=tty --ignore="\$Recycle.Bin" --ignore="\$RECYCLE.BIN" --ignore="System Volume Information" --ignore="ntuser*" --ignore="NTUSER*"'
alias ll='ls -lhF --color=tty --ignore="\$Recycle.Bin" --ignore="\$RECYCLE.BIN" --ignore="System Volume Information" --ignore="ntuser*" --ignore="NTUSER*"'
alias la='ls -AhF --color=tty --ignore="\$Recycle.Bin" --ignore="\$RECYCLE.BIN" --ignore="System Volume Information" --ignore="ntuser*" --ignore="NTUSER*"'
alias lc='ls -ChF --color=tty --ignore="\$Recycle.Bin" --ignore="\$RECYCLE.BIN" --ignore="System Volume Information" --ignore="ntuser*" --ignore="NTUSER*"'                              

# Some msys2 aliases
alias open='start'
