#! /bin/bash

STEAM_PROTON_PATH=~/.steam/steam/compatibilitytools.d/
LATEST_GIT_PROTONGE=https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest

function download_protonge {
    echo "Downloading $LatestProton"
    curl $LATEST_GIT_PROTONGE -s | grep "browser_download_url.*tar.gz" | cut -d : -f 2,3 | tr -d \" | wget -qi - --show-progress
    echo "Extracting $LatestProtonFile"
    tar -xf "$LatestProtonFile"
}

function delete_protonge {
    echo "Clearing all Proton files"
    rm -r -f *
}


cd "$STEAM_PROTON_PATH" # Switch to the Steam Proton folder

CurrentProtonFile=$(find $STEAM_PROTON_PATH -name "*.tar.gz")
CurrentProton=$(basename $CurrentProtonFile .tar.gz)

LatestProtonFile=$(curl -s $LATEST_GIT_PROTONGE | grep "browser_download_url.*tar.gz" | cut -d : -f 2,3 | xargs basename) # Read latest version online

LatestProton=$(basename "$LatestProtonFile" .tar.gz) # Remove extension

if [ -z "$CurrentProtonFile" ]; then
    echo "No ProtonGE files found"
    echo "Latest Version: $LatestProton"
    while true; do
        echo "1) Install"
        echo "2) Quit"
        read -p "Choose an option: " val
        case $val in
            [1]* )
                download_protonge
                echo "Done!"
                exit
                ;;
            [2]* ) exit ;;
            * ) echo "Please enter a valid number.";;
        esac
    done
else
    echo "Current Version: $CurrentProton"
    echo "Latest Version: $LatestProton"
    while true; do
        echo "1) Upgrade"
        echo "2) Delete"
        echo "3) Quit"
        read -p "Choose an option: " val
        case $val in
            [1]* )
                delete_protonge
                download_protonge
                echo "Done!"
                exit
                ;;
            [2]* )
                delete_protonge
                echo "Done!"
                exit
                ;;
            [3]* ) exit ;;
            * ) echo "Please enter a valid number.";;
        esac
    done
fi
