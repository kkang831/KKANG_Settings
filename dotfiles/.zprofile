
#!/bin/zsh

# 심볼릭 링크가 가리키는 대상 파일 경로
symbolicLinkPath=".zshrc"

# 심볼릭 링크의 유효성을 검사
if [ ! -e "$symbolicLinkPath" ]; then
  echo "Mounting jarvis, bean, mango."
  # 여기에 원하는 명령어를 추가하세요. 예를 들면:
  ~/mount_jarvis
fi