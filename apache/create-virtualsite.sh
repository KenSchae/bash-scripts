#!/bin/bash

# This script will create a new virtual site in Apache.
# 1. Create site directory and put a test index.html
# 2. Set permissions
# 3. Create Apache configuration
# 4. Activate virtual dir and restart Apache
# 5. Update hosts file
#
# Args
# -d the full path to the web site (usually in /var/www)
# -n the name of the virtual site
# -o the owner of the site
#
#
# Author: Ken Schaefer

while getopts d:n:o: option
do
    case "${option}"
        in
        d)sitedirectory=${OPTARG};;
        n)sitename=${OPTARG};;
        o)owner=${OPTARG};;
    esac
done

echo "Creating new directory for virtual site: $sitedirectory"
mkdir "$sitedirectory"
cd "$sitedirectory"
 
echo -e "<html>
    \t<head><title>Virtual Site</title></head>\n
    \t<body><h1>Virtual Site for $sitename</h1></body>\n
</html>" > "index.html"

# Give Apache access to the files and folders in the site
echo "Giving Apache access to virtual site: $sitedirectory"
chgrp -R www-data $sitedirectory
find $sitedirectory -type d -exec chmod g+rx {} +
find $sitedirectory -type d -exec chmod g+r {} +

# Give owner account read/write permission to the site
echo "Giving ownership of $sitedirectory to $owner"
chown -R $owner $sitedirectory
find $sitedirectory -type d -exec chmod u+rxw {} +
find $sitedirectory -type f -exec chmod u+rw {} +

# Add the new virtual site to Apache
echo "Creating Apache virtual site configuration file"
cd /etc/apache2/sites-available
echo -e "
<VirtualHost *:80>\n
    \tServerName "$sitename"\n
    \tServerAlias "$sitename"\n\n
    \tServerAdmin "$owner"\n
    \tDocumentRoot "$sitedirectory"\n\n
    \tErrorLog "${APACHE_LOG_DIR}/$sitename-error.log"\n
    \tCustomLog "${APACHE_LOG_DIR}/$sitename-access.log combined"\n
</VirtualHost>" > "$sitename.conf"

echo "Activating and enabling virtual site"
a2ensite "$sitename.conf"
systemctl restart apache2

echo "Updating hosts file with new virtual site"
echo -e "\n\n127.0.0.1\t$sitename" >> /etc/hosts