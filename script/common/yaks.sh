#!/bin/bash
#
# This is a yak-shaving script that installs the OS prerequisites required to run docker commands.
# It's meant to be used in the prelude of other scripts that involve working with docker with
# "source", so exported variables will be available if "boot2docker shellinit" is required.

# -- Useful functions.

# A quick test to verify that a binary is installed and available on your $PATH.
has()
{
  which $1 >/dev/null 2>&1
  return $?
}

# -- Install docker if it's absent.

if ! has docker; then
  case $OSTYPE in
    darwin*)
      if ! has brew; then
        echo "Installing homebrew."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      fi

      echo "Installing docker via homebrew."
      brew install boot2docker

      echo "Initializing the boot2docker VM."
      boot2docker init
      ;;
    *)
      echo "Installing docker via <https://get.docker.com>."

      if has curl; then
        curl -sSL https://get.docker.com/ | sh
      elif has wget; then
        wget -qO- https://get.docker.com/ | sh
      else
        echo "Neither curl nor wget is available."
        echo "You'll need to install docker yourself. Sorry!"
        exit 1
      fi
      ;;
  esac
fi

# -- Start boot2docker if needed.

if has boot2docker; then
  STATUS=$(boot2docker status 2>&1)
  case $STATUS in
    running)
      ;;
    poweroff)
      boot2docker up
      ;;
    *)
      echo "unrecognized boot2docker status:"
      echo " ${STATUS}"
      echo "You may just need to run:"
      echo " boot2docker init"
      exit 1
      ;;
  esac

  if [ -z "${DOCKER_CERT_PATH}" ] || [ -z "${DOCKER_TLS_VERIFY}" ] || [ -z "${DOCKER_HOST}" ]; then
    $(boot2docker shellinit)
  fi
fi
