#!/bin/bash

set -e

curl -O http://wordnetcode.princeton.edu/wn3.1.dict.tar.gz
tar xf wn3.1.dict.tar.gz
rm wn3.1.dict.tar.gz
