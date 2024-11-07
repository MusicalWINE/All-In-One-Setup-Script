#!/bin/bash

#Tell the user that we're installing the necessary software to make things work.
#No menu will be displayed until after the installation of the necessary software is done.

echo "Installing WINE, WineTricks, Zenity, Curl, and P7Zip. This part will install all fonts that WineTricks offers."

echo "This will require a SUDO password at least one time, but it may require a SUDO password some other times too. This part will install WINE and the necessary software."
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman -Syyu
sudo pacman -S wine winetricks zenity curl p7zip
echo "Done installing necessary software!"

echo "Getting the Winetricks script file to install all availble fonts!"
mkdir ~/tempdir
curl https://gitlab.com/winemusiccreation/winetricks/-/raw/master/src/winetricks -o ~/winetricks
chmod +x ~/winetricks && bash ~/winetricks allfonts
rm -rf ~/tempdir
echo "Done installing fonts!"

#Menu to let the user decide what they want to do. Do they want to install a DAW or one of the other programs?
echo "Please select an option. Would you like to install a DAW or another program?"
select option in DAW OtherProgram; do
case $option in

DAW)
    echo "Please select the DAW you would like to install"
    select DAW in Ableton FLStudio; do
    case $DAW in
        Ableton)
        curl https://gitlab.com/winemusiccreation/ableton/-/raw/12/AbletonLiveInstaller.sh --output ~/Downloads/AbletonLiveInstaller.sh
        chmod +x ~/Downloads/AbletonLiveInstaller.sh
        bash ~/Downloads/AbletonLiveInstaller.sh
        break
        ;;
        FLStudio)
        curl https://gitlab.com/winemusiccreation/flstudio/-/raw/main/FLStudioInstaller.sh --output ~/Downloads/FLStudioInstaller.sh
        chmod +x ~/Downloads/FLStudioInstaller.sh
        bash ~/Downloads/FLStudioInstaller.sh
        break
        ;;
    esac
    done
    ;;
OtherProgram)
    echo "Please select the program you would like to install"
    select choice in Splice Cymatics LANDR; do
    case $choice in
        Cymatics)
            curl https://gitlab.com/cymatics/-/raw/main/CymaticsInstaller.sh --output ~/Downloads/CymaticsInstaller.sh
            chmod +x ~/Downloads/CymaticsInstaller.sh
            bash ~/Downloads/CymaticsInstaller.sh
        break
        ;;
        LANDR)
            curl https://gitlab.com/cymatics/-/raw/main/LANDRInstaller.sh --output ~/Downloads/LANDRInstaller.sh
            chmod +x ~/Downloads/CymaticsInstaller.sh
            bash ~/Downloads/LANDRInstaller.sh
        break
        ;;
        Splice)
            curl https://gitlab.com/cymatics/-/raw/main/SpliceInstaller.sh --output ~/Downloads/SpliceInstaller.sh
            chmod +x ~/Downloads/SpliceInstaller.sh
            bash ~/Downloads/SpliceInstaller.sh
        break
        ;;

    esac
    done
    break
esac
done

echo "Would you like to install anything else?"
select option in Yes No; do
case $option in
    Yes)
        ./$(basename $0) && exit
        break
        ;;
    No)
        exit
        break
        ;;
esac
done
