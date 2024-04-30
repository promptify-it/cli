#!/bin/bash

# GitHub repository URL
REPO_URL="https://github.com/dedecube/dynamic-cli"

# Function to detect the user's platform
detect_platform() {
    case "$(uname -s)" in
        Linux*)
            if [ "$(uname -m)" = "x86_64" ]; then
                PLATFORM="linux_x86_64"
            elif [ "$(uname -m)" = "aarch64" ]; then
                PLATFORM="linux_aarch64"
            else
                echo "Unsupported Linux architecture"
                exit 1
            fi
            ;;
        Darwin*)
            if [ "$(uname -m)" = "x86_64" ]; then
                PLATFORM="macos_intel"
            elif [ "$(uname -m)" = "arm64" ]; then
                PLATFORM="macos_apple"
            else
                echo "Unsupported macOS architecture"
                exit 1
            fi
            ;;
        CYGWIN*|MINGW32*|MSYS*|MINGW*)
            PLATFORM="windows_x64"
            ;;
        *)
            echo "Unsupported platform"
            exit 1
            ;;
    esac
    echo "$PLATFORM"
}

# Function to download the appropriate build based on platform
download_build() {
    PLATFORM=$1
    case "$PLATFORM" in
        linux_x86_64)
            # Download Linux x86_64 build
            curl -LOs "$REPO_URL/builds/linux_x86_64/dcli"
            chmod +x dcli
            sudo mv dcli /usr/local/bin/
            ;;
        linux_aarch64)
            # Download Linux aarch64 build
            curl -LOs "$REPO_URL/builds/linux_aarch64/dcli"
            chmod +x dcli
            sudo mv dcli /usr/local/bin/
            ;;
        macos_intel)
            # Download macOS Intel build
            curl -LOs "$REPO_URL/builds/macos_intel/dcli"
            chmod +x dcli
            sudo mv dcli /usr/local/bin/
            ;;
        macos_apple)
            # Download macOS Apple Silicon build
            curl -LOs "$REPO_URL/builds/macos_apple/dcli"
            chmod +x dcli
            sudo mv dcli /usr/local/bin/
            ;;
        windows_x64)
            # Download Windows x64 build
            curl -LOs "$REPO_URL/builds/windows_x64/dcli.exe"
            echo "For Windows, please move the dcli.exe file to a directory in your PATH manually."
            ;;
        *)
            echo "Unsupported platform"
            exit 1
            ;;
    esac
}

# Main function
main() {
    PLATFORM=$(detect_platform)
    download_build "$PLATFORM"
    # download_bash_autocomplete
    # download_zsh_autocomplete
}

# Execute the main function
main
