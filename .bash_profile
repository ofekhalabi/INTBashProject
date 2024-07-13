# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

#print hello to user 
USER_NAME=$(whoami)
echo "HELLO $USER_NAME"

export COURSE_ID="DevOpsTheHardWay"

# check if the file .token in the home directory exist and check the permmisions
if [[ -e "/home/$USER_NAME/.token" ]] ; then
	token_FILE_PER=$(stat -c "%a" .token)
	if [[ $token_FILE_PER -eq "600" ]] ; then
		echo "Warning: .token file has too open permissions"
	fi
fi

#change the permmisions file to read and write to user and group only
umask 006

#Add /home/<username>/usercommands (while <username> is the linux username) to the end of the PATH env var
if [[ -d /home/$USER_NAME/usercommands ]];then
	PATH=$PATH:/home/$USER_NAME/usercommands
else
	mkdir /home/$USER_NAME/usercommands
	PATH=$PATH:/home/$USER_NAME/usercommands
fi

#Print the current date on screen in ISO 8601 format. 
echo The current date is: $(date --iso-8601=ns)

alias ltxt="ls -la | grep .txt"

#check if ~/tmp exist ,If it doesn't exist, create the ~/tmp directory on the user's home dir. If it exists, clean it (delete all the directory's content without removing the dir itself).

if [[ -d /home/$USER_NAME/tmp ]]; then
	cd /home/$USER_NAME/tmp
	if [[ "$(ls | wc -l)" -ge "1" ]]; then
		rm -f -d /home/$USER_NAME/tmp/*
	fi
else
	mkdir /home/$USER_NAME/tmp
fi

cd /home/$USER_NAME
