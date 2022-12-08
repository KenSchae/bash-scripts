#!/bin/sh

echo "Virtual site folder"
read FOLDER
echo "Owner account"
read ACCOUNT

# Give Apache access to the files and folders in the site
echo "Giving Apache access to $FOLDER"
chgrp -R www-data $FOLDER
find $FOLDER -type d -exec chmod g+rx {} +
find $FOLDER -type f -exec chmod g+r {} +

# Give owner account read/write permission to the site
echo "Giving ownership of $FOLDER to $ACCOUNT"
chown -R $ACCOUNT $FOLDER
find $FOLDER -type d -exec chmod u+rxw {} +
find $FOLDER -type f -exec chmod u+rw {} +
