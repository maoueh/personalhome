# a) function settitle
# settitle () 
# { 
#   echo -ne "\e]2;$@\a\e]1;$@\a"; 
# }
# 
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null
 
   #
   # Remove any other occurence of this dir, skipping the top of the stack
   for ((cnt=1; cnt <= 10; cnt++)); do
     x2=$(dirs +${cnt} 2>/dev/null)
     [[ $? -ne 0 ]] && return 0
     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
     if [[ "${x2}" == "${the_new_dir}" ]]; then
       popd -n +$cnt 2>/dev/null 1>/dev/null
       cnt=cnt-1
     fi
   done
 
   return 0
}
 
alias cd=cd_func

export_path() {
  # Prepend
  PATH="$SYSTEM_PATH"
  PATH="$GRADLE_ROOT/bin:$JAVA_ROOT/bin:$PATH"
  PATH="$MAVEN_ROOT/bin:$NODE_ROOT:$MINGW_ROOT/bin:$PATH"
  PATH="$MYSQL_ROOT/bin:$NOTEPADPP_ROOT:$PATH"
  PATH="$PYTHON_ROOT:$PYTHON_ROOT/Scripts:$PATH"
  PATH="$RUBY_ROOT/bin:$SVN_ROOT/bin:$PATH"
  PATH="$VAGRANT_ROOT/bin:$VIRTUAL_BOX_ROOT:$PATH"
  
  if [ -d "${HOME}/local/bin" ]; then
	PATH="${HOME}/local/bin:${PATH}"
  fi
  
  # Append
  PATH="$PATH:$GIT_ROOT/cmd"

  export INFOPATH="${HOME}/local/info:${MINGW_ROOT}/info:${INFOPATH}"
  export JAVA_HOME="$JAVA_ROOT"
  export PKG_CONFIG_PATH="${HOME}/local/lib/pkgconfig:${MINGW_ROOT}/lib/pkgconfig:${PKG_CONFIG_PATH}"
  export MANPATH="${HOME}/local/man:${MINGW_ROOT}/share/man:${MANPATH}"
  export PATH
}
