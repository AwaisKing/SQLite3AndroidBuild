#!/bin/bash

# set +e

content=$(curl -sSL 'https://www.sqlite.org/download.html')
regex='PRODUCT,([^,]+),([0-9]{4})\/([^,]+amalgamation[^,]+)'

if [[ $content =~ $regex ]]; then
    version="${BASH_REMATCH[1]}"
    year="${BASH_REMATCH[2]}"
    path="${BASH_REMATCH[3]}"

    [[ "$path" != *.zip ]] && path="${path}.zip"

    sqliteUrl="https://www.sqlite.org/${year}/${path}"
else
    sqliteUrl="https://www.sqlite.org/2026/sqlite-amalgamation-3520000.zip"
fi

[[ "$sqliteUrl" == "" ]] && exit 1




# taken from:
#   1: https://raw.githubusercontent.com/tdlib/td/refs/heads/master/example/android/check-environment.sh
#   2: https://raw.githubusercontent.com/tdlib/td/refs/heads/master/example/android/fetch-sdk.sh



OS_NAME="linux"
HOST_ARCH="linux-x86_64"
SDKMANAGER="./sdkmanager"
ANDROID_SDK_ROOT="SDK"

ANDROID_NDK_VERSION="29.0.14206865"
BUILD_TOOLS_VERSION="36.1.0"
CMAKE_VERSION="4.1.2"


if [ -e "$ANDROID_SDK_ROOT" ] ; then
  rm -rf "$ANDROID_SDK_ROOT"
fi


if which wget >/dev/null 2>&1 ; then
  WGET="wget -q"
elif which curl >/dev/null 2>&1 ; then
  WGET="curl -sfLO"
else
  echo "Error: this script supports only Bash shell on Linux, macOS, or Windows."
  exit 1
fi

# for TOOL_NAME in gperf jar java javadoc make perl php sed tar yes unzip ; do
  # if ! which "$TOOL_NAME" >/dev/null 2>&1 ; then
    # echo "Error: this script requires $TOOL_NAME tool installed."
    # exit 1
  # fi
# done

# if [[ $(which make) = *" "* ]] ; then
  # echo "Error: OpenSSL expects that full path to make tool doesn't contain spaces. Move it to some other place."
  # exit 1
# fi

# if ! perl -MExtUtils::MakeMaker -MLocale::Maketext::Simple -MPod::Usage -e '' >/dev/null 2>&1 ; then
  # echo "Error: Perl installation is broken."
  # if [[ "$OSTYPE" == "msys" ]] ; then
    # echo "For Git Bash you need to manually copy ExtUtils, Locale and Pod modules to /usr/share/perl5/core_perl from any compatible Perl installation."
  # fi
  # exit 1
# fi

# if ! java --help >/dev/null 2>&1 ; then
  # echo "Error: Java installation is broken. Install JDK from https://www.oracle.com/java/technologies/downloads/ or via the package manager."
  # exit 1
# fi

# echo "Downloading SDK Manager..."
# mkdir -p "$ANDROID_SDK_ROOT" || exit 1
# cd "$ANDROID_SDK_ROOT" || exit 1
# $WGET "https://dl.google.com/android/repository/commandlinetools-$OS_NAME-14742923_latest.zip" || exit 1
# mkdir -p cmdline-tools || exit 1
# unzip -qq "commandlinetools-$OS_NAME-14742923_latest.zip" -d cmdline-tools || exit 1
# rm "commandlinetools-$OS_NAME-14742923_latest.zip" || exit 1
# mv cmdline-tools/* cmdline-tools/latest/ || exit 1

# echo "Installing required SDK tools..."
# cd cmdline-tools/latest/bin/ || exit 1
# yes | $SDKMANAGER --licenses >/dev/null || exit 1
# $SDKMANAGER --install "ndk;$ANDROID_NDK_VERSION" "cmake;$CMAKE_VERSION" "build-tools;$BUILD_TOOLS_VERSION" "platforms;android-36" > /dev/null || exit 1

# cd ../../../


##################### my stuff #####################
rm *.zip >/dev/null 2>&1

[ -e build ] || exit 1

echo "downloading sqlite3 amalgamation from: $sqliteUrl"
$WGET "$sqliteUrl" || exit 1

unzip -qq "${sqliteUrl##*/}" || exit 1

ls -l

mv sqlite* sqlite-build >/dev/null 2>&1 || mv *amalgamation* sqlite-build >/dev/null 2>&1
[ -e sqlite-build ] || exit 1

mv sqlite-build build/

rm *.zip >/dev/null 2>&1

# cd sqlite-build

export NDK_PROJECT_PATH=$(pwd)

echo "curr dir : $NDK_PROJECT_PATH"

find .
