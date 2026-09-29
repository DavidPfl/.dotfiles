#!/bin/bash

if [ -d /tmp/.workmux-shims/bin ]; then
  PATH="/tmp/.workmux-shims/bin:$PATH"
  export PATH
fi
