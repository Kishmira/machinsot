#Credit: https://github.com/Area69Lab
#setup.sh VNC_USER_PASSWORD VNC_PASSWORD NGROK_AUTH_TOKEN

#disable spotlight indexing
sudo mdutil -i off -a

#Create new account
sudo dscl . -create /Users/devlop
sudo dscl . -create /Users/devlop UserShell /bin/bash
sudo dscl . -create /Users/devlop RealName "Devlop"
sudo dscl . -create /Users/devlop UniqueID 1001
sudo dscl . -create /Users/devlop PrimaryGroupID 80
sudo dscl . -create /Users/devlop NFSHomeDirectory /Users/vncuser
sudo dscl . -passwd /Users/devlop $1
sudo dscl . -passwd /Users/devlop $1
sudo createhomedir -c -u devlop > /dev/null
#
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users admin -privs -all -restart -agent -menu
#
#Enable VNC
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvnclegacy -vnclegacy yes 
#
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -console
#
#VNC password - http://hints.macworld.com/article.php?story=20071103011608872
echo $2 | perl -we 'BEGIN { @k = unpack "C*", pack "H*", "1734516E8BA8C5E2FF1C39567390ADCA"}; $_ = <>; chomp; s/^(.{8}).*/$1/; @p = unpack "C*", $_; foreach (@k) { printf "%02X", $_ ^ (shift @p || 0) }; print "\n"' | sudo tee /Library/Preferences/com.apple.VNCSettings.txt






#Start VNC/reset changes
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -console
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate

#install ngrok
brew install --cask ngrok

#configure ngrok and start it
ngrok authtoken $3
ngrok tcp 5900 --region=in &
