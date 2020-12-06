#!/bin/sh

set -xe

mitamae_version="1.11.7"
curl -sL -o /usr/local/bin/mitamae https://github.com/itamae-kitchen/mitamae/releases/download/v${mitamae_version}/mitamae-x86_64-linux
chmod +x /usr/local/bin/mitamae
mitamae version
