#!/bin/sh

set -eu

: "${PT_PROJECT_TOKEN:?'You must set the PT_PROJECT_TOKEN secret'}"

if [ -e yarn.lock ]; then
  if ! yarn install; then
    echo "yarn install failed" 1>&2
    exit 1
  fi

  yarn add @packtracker/webpack-plugin@2.0.1
else
  if ! npm install; then
    echo "npm install failed" 1>&2
    exit 1
  fi

  npm install @packtracker/webpack-plugin@2.0.1
fi

cp /report.js ./report.js
node ./report.js
rm ./report.js

if [ -e yarn.lock ]; then
  yarn remove @packtracker/webpack-plugin
else
  npm uninstall @packtracker/webpack-plugin
fi
