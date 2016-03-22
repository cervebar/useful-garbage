
export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_05/
export PATH=$PATH:/usr/lib/jvm/jdk1.8.0_05/bin
export PATH=$PATH:/home/babu/app/activator-1.2.3-minimal/activator

# Most of the time you don’t want to maintain two separate config files for login and non-login shells
# when you set a PATH, you want it to apply to both

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi


