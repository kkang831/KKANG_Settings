#!/bin/bash

# 삭제할 파일의 패턴 (예: *.tmp, *.log 등)
FILE_PATTERN="model_2.*"

# 시작 폴더 (현재 폴더에서 시작)
START_DIR="."

# 하위 폴더를 포함하여 파일을 검색하고 삭제
find "$START_DIR" -type f -name "$FILE_PATTERN" -exec rm -f {} \;

echo "삭제가 완료되었습니다."
