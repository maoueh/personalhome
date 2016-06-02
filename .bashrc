# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any warranty.
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software.
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

# base-files version 4.1-1

# ~/.bashrc: executed by bash(1) for interactive shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

#
## Shell Options
#

# Don't wait for job termination notification
set -o notify

# Use case-insensitive filename globbing
shopt -s nocaseglob

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Don't use ^D to exit
# set -o ignoreeof

#
## Completion options
#

# Define to access remotely checked-out files over passwordless ssh for CVS
COMP_CVS_REMOTE=1

# Define to avoid stripping description in --option=description of './configure --help'
COMP_CONFIGURE_HINTS=1

# Define to avoid flattening internal contents of tar files
COMP_TAR_INTERNAL_PATHS=1

# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

#
## History Options
#

# Unlimited history
export HISTFILESIZE=
export HISTSIZE=

# Custom history to avoid some session truncating to 500
export HISTFILE=~/.shell_history

# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:ll' # Ignore the ls and ll commands as well

# Whenever displaying the prompt, write the previous line to disk
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a"

#
## Bash Scripts
#

for bash_script_file in $(export LC_COLLATE=C; echo ~/.bash.d/*.sh); do
  [ -e "${bash_script_file}" ] && . "${bash_script_file}"
done

#
## Environment
#

# File for environment variables definitions
if [ -f "${HOME}/.bash_env" ]; then
  source "${HOME}/.bash_env"
fi

#
## Aliases
#

if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi

#
## Functions
#

if [ -f "${HOME}/.bash_functions" ]; then
  source "${HOME}/.bash_functions"
fi

#
## Umask
#

# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

#
## Re-execute Handling
#

if [ ! -z "$CWD" ]; then
  cd "$CWD"
fi
