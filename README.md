<!-- ----------------------------------------- -->
## Install
```bash
# Install at new computer
git clone --recursive git@github.com:kkang831/KKANG_Settings.git
git clone --recursive https://github.com/kkang831/KKANG_Settings.git
```

```bash
# If there exists git directory
cd KKANG_Settings
./kk_init
git remote set-url origin git#@github.com:kkang831/KKANG_Settings.git
```

<!-- ----------------------------------------- -->
## Subdirectories

### Files
- kk_init
  - initial environment setting file
  - run kk_link && exec zsh && kk
- kk_link
  - link symbolic links
- kk
  - related to git commit, pull, push, 

### Dirs
- notes
  - include some memos
- ohmyzsh
  - ohmyzsh submodule
- zsh
  - ohmyzsh setting files
  - I use set_agnoster.zsh
- fonts
  - some fonts





<!-- ----------------------------------------- -->
## Update History

### 25.05.27
  - Git init
    - Git subdirectory add oh my zsh
    - Add
      - notes
      - zsh
      - fonts
      - dotfiles

### 25.06.08
  - 