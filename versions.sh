#!/bin/bash

main () {
  for CMD in \
    'curl --version' \
    'wget --version' \
    'unzip -v' \
    'bzip2 --version' \
    'xz --version' \
    'git --version' \
    'rsync --version' \
    'eb --version' \
    'aws --version' \
    'jq --version' \
    'ansible --version' \
    'openssl version' \
    'ssh -V'; do
    $CMD 2>&1 | head -1
  done
}

main "$@"
