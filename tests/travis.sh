#!/bin/bash
set -o nounset
set -o errexit

npm install

# lint
npm run eslint

# run tests appropriate for platform
if [[ "$PLATFORM" == "ios" ]]; then
    npm run test:ios
fi
if [[ "$PLATFORM" == "android" ]]; then
    echo no | android create avd --force -n test -t android-21 --abi armeabi-v7a
    emulator -avd test -no-audio -no-window &
    android-wait-for-emulator
    npm run test:android
fi