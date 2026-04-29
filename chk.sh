#!/bin/zsh

wsm="./ms2hms.wasm"

wrun(){
  local msval
  msval=$1
  readonly msval

  wasmer \
    run \
    --invoke ms2hms \
    "${wsm}" \
    ${msval}
}

echo 0 ms
wrun 0
echo

echo 999 ms
wrun 999
echo

echo 1000 ms
wrun 1000
echo

echo 59000 ms
wrun 59000
echo

echo 60000 ms
wrun 60000
echo

echo 119000 ms
wrun 119000
echo

echo 120000 ms
wrun 120000
echo

echo 3599000 ms
wrun 3599000
echo

echo 3600000 ms
wrun 3600000
echo

echo 7199999 ms
wrun 7199999
echo

echo 7200000 ms
wrun 7200000
echo

echo 86399999 ms
wrun 86399999
echo
