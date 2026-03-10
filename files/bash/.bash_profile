# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Host-specific bash_profile settings
if [ -f ~/.custom_bash_profile ]; then
    . ~/.custom_bash_profile
fi
