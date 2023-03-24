#!/data/data/com.termux/files/usr/bin/bash
# gpt made
# This script clones a given repository into the zsh_custom/plugins directory and adds it to the plugins list in .zshrc
# Usage: ./install_plugin.sh username/reponame

# Check if oh-my-zsh is installed
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "oh-my-zsh is installed."
else
    echo "oh-my-zsh is not installed. Please install it first."
    exit 1
fi

# Check if the argument is valid
if [ $# -eq 1 ]; then
    echo "The argument is $1."
else
    echo "Invalid argument. Please provide a valid username/reponame."
    exit 2
fi

# Extract the username and the reponame from the argument
username=$(echo $1 | cut -d '/' -f 1)
reponame=$(echo $1 | cut -d '/' -f 2)

# Clone the repository into the zsh_custom/plugins directory
git clone https://github.com/$username/$reponame ${zsh_custom:-~/.oh-my-zsh/custom}/plugins/$reponame

# Check if the clone was successful
if [ $? -eq 0 ] || [ $? -eq 1 ]; then
    echo "$reponame cloned successfully."
else
    echo "$reponame clone failed. Please check your internet connection and try again."
    exit 3
fi

# Add $reponame to the plugins list in .zshrc
sed -i "s/plugins=(\(.*\))/plugins=(\1 $reponame)/" ~/.zshrc

# Check if the sed command was successful
if [ $? -eq 0 ]; then
    echo "$reponame added to the plugins list in .zshrc."
else
    echo "$reponame addition failed. Please edit your .zshrc file manually and add $reponame to the plugins list."
    exit 4
fi