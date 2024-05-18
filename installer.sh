#!/bin/bash

USERNAME="promptify-it"
REPO="cli"
REPO_URL="https://github.com/promptify-it/cli"

# Get the latest release tag name
latest_release=$(curl -s "https://api.github.com/repos/$USERNAME/$REPO/releases/latest")

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

    DOWNLOAD_URL=$(curl -s "https://api.github.com/repos/$USERNAME/$REPO/releases/latest" | jq -r --arg PLATFORM "$PLATFORM" '.assets[] | select(.name | contains($PLATFORM)) | .browser_download_url')
    FILE_NAME=pfy_${PLATFORM}

    case "$PLATFORM" in
        linux_x86_64)
            curl -LOs $DOWNLOAD_URL
            chmod +x ${FILE_NAME}
            mv ${FILE_NAME} pfy
            sudo mv pfy /usr/local/bin/
            ;;
        linux_aarch64)
            curl -LOs $DOWNLOAD_URL
            chmod +x ${FILE_NAME}
            mv ${FILE_NAME} pfy
            sudo mv pfy /usr/local/bin/
            ;;
        macos_intel)
            curl -LOs $DOWNLOAD_URL
            chmod +x ${FILE_NAME}
            mv ${FILE_NAME} pfy
            sudo mv pfy /usr/local/bin/
            ;;
        macos_apple)
            curl -LOs $DOWNLOAD_URL
            chmod +x ${FILE_NAME}
            mv ${FILE_NAME} pfy
            sudo mv pfy /usr/local/bin/
            ;;
        windows_x64)
            # Download Windows x64 build
            curl -LOs $DOWNLOAD_URL
            echo "For Windows, please move the pfy.exe file to a directory in your PATH manually."
            ;;
        *)
            echo "Unsupported platform"
            exit 1
            ;;
    esac
}

main() {
    PLATFORM=$(detect_platform)
    download_build "$PLATFORM"
}

main
