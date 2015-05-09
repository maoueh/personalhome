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

##
# Calls system editor defined by "$EDITOR" that you
# put in your `.bash_env` file.
#
edit() {
  ${EDITOR} "$@"
}

explorer() {
  if [ $# -eq 0 ]
  then
    local current_directory=`pwd`
    explorer.exe `cygpath -w "${current_directory}"`
  elif [ $# -eq 1 ]
  then
    explorer.exe `cygpath -w "$1"`
  else
    # TODO: Support multiple arguments
    echo "explorer: multiple arguments not supported"
  fi
}

##
# This function start a new bash with the correct path defined
# for the specified toolchain passed in argument effectively
# changing build environment. When no argument is passed,
# it prints the current defined toolchain.
#
toolchain() {
  # TODO: transform to map
  local mingw64_name=mingw64
  local mingw64_path=/mingw64

  local msys2_name=msys2
  local msys2_path=/usr

  local rpi_name=rpi
  local rpi_path=/opt/crosstool/arm-linux-gnueabihf

  if [ $# -eq 0 ]
  then
	case "$TOOLCHAIN_ROOT" in
	$mingw64_path)
	  echo "Current toolchain: ${mingw64_name}"
	  ;;
	$msys2_path)
	  echo "Current toolchain: ${msys2_name}"
	  ;;
	$rpi_path)
	  echo "Current toolchain: $rpi_name"
	  ;;
	*)
	  echo "Unknown toolchain path: ${TOOLCHAIN_ROOT}"
	  ;;
	esac
  else
	case "$1" in
	$mingw64_name)
	  echo "Activating toolchain '$1' (in new bash process)"
	  TOOLCHAIN_ROOT="${mingw64_path}" bash --login -i
	  ;;
	$msys2_name)
	  echo "Activating toolchain '$1' (in new bash process)"
	  TOOLCHAIN_ROOT="${msys2_path}" bash --login -i
	  ;;
	$rpi_name)
	  echo "Activating toolchain '$1' (in new bash process)"
	  TOOLCHAIN_ROOT="${rpi_path}" bash --login -i
	  ;;
	esac
  fi
}
