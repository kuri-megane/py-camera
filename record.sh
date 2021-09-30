#!/bin/bash
set -eu

function catch {
  echo "シェル異常終了" >> "$THIS_FILE_PATH"/log/pi-camera.log
}
function finally {
  echo "シェル正常終了" >> "$THIS_FILE_PATH"/log/pi-camera.log
}
trap catch ERR
trap finally EXIT

THIS_FILE_PATH=$(cd $(dirname $0); pwd)
cd "$THIS_FILE_PATH" || exit

# タイムアウトの時刻はmain.pyの処理時間と合わせる
timeout -sKILL 3600 /usr/bin/python3 "$THIS_FILE_PATH"/main.py >> "$THIS_FILE_PATH"/log/pi-camera.log 2>&1
