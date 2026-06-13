# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export WAYLAND_DISPLAY=wayland-1
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions fzf-tab)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Aliases
alias clr="clear"
alias find="fd"
alias grep="rg"
alias aseprite="libresprite"

cp_any() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: cp_any <.ext1> [.ext2] ..." >&2
        return 1
    fi

    local fence='```'
    local find_args=()
    for ext in "$@"; do
        [[ "$ext" != .* ]] && ext=".${ext}"
        [[ ${#find_args[@]} -gt 0 ]] && find_args+=(-o)
        find_args+=(-name "*${ext}")
    done

    local exclude_dirs=("build" "dist" "node_modules" ".git" "target")
    local prune_args=()
    for dir in "${exclude_dirs[@]}"; do
        [[ ${#prune_args[@]} -gt 0 ]] && prune_args+=(-o)
        prune_args+=(-path "*/${dir}/*")
    done

    command find . -type f \( "${prune_args[@]}" \) -prune -o \
        -type f \( "${find_args[@]}" \) -print | sort | \
    while IFS= read -r file; do
        echo "$fence"
        echo "// $file"
        cat "$file"
        echo "$fence"
    done
}

copy() {
    "$@" | wl-copy
}

# cppinit — scaffold a CMake C++ project
# Add to ~/.zshrc: source /path/to/cppinit.zsh

function cppinit() {
  if [[ -z "$1" ]]; then
    echo "Usage: cppinit <project-name>"
    return 1
  fi

  local project="$1"

  if [[ -d "$project" ]]; then
    echo "Error: directory '$project' already exists."
    return 1
  fi

  echo "Creating project: $project"

  # --- Directory structure ---
  mkdir -p "$project"/{src,build}

  # --- src/main.cpp ---
  cat > "$project/src/main.cpp" <<EOF
#include <iostream>

int main() {
    std::cout << "Hello from $project!" << std::endl;
    return 0;
}
EOF

  # --- CMakeLists.txt ---
  cat > "$project/CMakeLists.txt" <<EOF
cmake_minimum_required(VERSION 3.20)
project($project VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(\${PROJECT_NAME} src/main.cpp)

target_compile_options(\${PROJECT_NAME} PRIVATE
    -Wall
    -Wextra
    -Wpedantic
)
EOF

  # --- .gitignore ---
  cat > "$project/.gitignore" <<EOF
build/
.cache/
compile_commands.json
*.o
*.a
*.so
EOF

  # --- README.md ---
  cat > "$project/README.md" <<EOF
# $project

## Build

\`\`\`sh
cd build
cmake ..
cmake --build .
\`\`\`

## Run

\`\`\`sh
./build/$project
\`\`\`
EOF

  # --- Git init ---
  git -C "$project" init --quiet
  git -C "$project" add .
  git -C "$project" commit --quiet -m "initial commit"

  echo ""
  echo "Done! Project '$project' is ready."
  echo ""
  echo "  cd $project/build"
  echo "  cmake .."
  echo "  cmake --build ."
  echo "  ./$project"
}

fmount() {
    if [ -z "$1" ]; then
	echo "no partition name given, aborting..."
	return 1
    fi

    folder_name="$1"
    if [ ! -z "$2" ]; then
	folder_name="$2"
    fi

    sudo mkdir /mnt/"$folder_name"
    sudo mount /dev/"$1" /mnt/"$folder_name"
    cd /mnt/"$folder_name"
}

movetors() {
    cp "$1" /home/Gennaro/.var/app/org.vinegarhq.Vinegar/data/vinegar/prefixes/studio/drive_c/users/Gennaro/Downloads
}

copyluautemplate() {
    echo "--!strict\n\n-- Services\n\n-- Variables\n\n-- Functions" | wl-copy
}

yt_dlp_sh() {
    argument="$1"
    link="$2"

    if [ -z "$argument" ]; then
        echo "Missing argument"
        return 1
    fi
    if [ -z "$link" ] && [[ "$argument" != "--help" && "$argument" != "-h" ]]; then
        echo "Missing link"
        return 1
    fi

    if [[ "$argument" = "--help" || "$argument" = "-h" ]]; then
        echo "Usage:"
        echo "  yt_dlp_sh [ARGUMENT] [LINK]"
        echo ""
        echo "  Arguments:"
        echo "    --help | -h    Display this help message"
        echo "    --audio | -3   Download as mp3"
        echo "    --video | -4   Download as mp4"
        return 0
    fi

    if [[ "$argument" = "--audio" || "$argument" = "-3" ]]; then
        yt-dlp -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 "$link"
    fi

    if [[ "$argument" = "--video" || "$argument" = "-4" ]]; then
        yt-dlp -f "bestvideo+bestaudio" --merge-output-format mp4 "$link"
    fi
}

if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
    exec tmux
fi

# Env vars
EDITOR="nvim"

# Keep these on the bottom.
autoload -Uz compinit && compinit
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
amnosia remind

[ -f "/home/Gennaro/.ghcup/env" ] && . "/home/Gennaro/.ghcup/env" # ghcup-env