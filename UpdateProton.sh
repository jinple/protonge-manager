#! /bin/bash

STEAM_PROTON_PATH=~/.steam/steam/compatibilitytools.d/

cd "$STEAM_PROTON_PATH" # Switch to the Steam Proton folder

if [ $1 = "update" ]; then # If user wants to update Proton
    LatestProton=$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest | grep "browser_download_url.*tar.gz" | cut -d : -f 2,3 | xargs basename)

    if test -f "$LatestProton"; then
        echo "No new updates!"
    else
        LatestProtonClean=$(basename "$LatestProton" .tar.gz) # Remove extension
        echo "New update available! - $LatestProtonClean"

        echo "Clearing all Proton files"
        rm -r -f *

        echo "Downloading latest version"
        curl https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest | grep "browser_download_url.*tar.gz" | cut -d : -f 2,3 | tr -d \" | wget -qi -

        echo "Extracting Proton"
        tar -xf "$LatestProton"

        echo "Done!"
    fi
elif [ $1 = "version" ]; then # If user wants to see current Proton version
    ls *.tar.gz | sed -e 's/\.tar.gz$//'
elif [ $1 = "delete" ]; then # If user wants to see current Proton version
    echo "Clearing all Proton files"

    rm -r -f *

    echo "Done!"
elif [ $1 = "latest" ]; then # If user wants to see the latest Proton version available
    LatestProton=$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest | grep "browser_download_url.*tar.gz" | cut -d : -f 2,3 | xargs basename) # Read latest version online

    LatestProton=$(basename "$LatestProton" .tar.gz) # Remove extension

    echo "$LatestProton" # Show version
fi
