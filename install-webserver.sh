#!/bin/bash
# Super simple install script for an Nginx webserver with a custom index.html file

#
# Check if the Effective User ID is NOT EQUAL to 0, 
# basically checking if script is ran with root privileges.
#
# WARNING: Not applicable in dash shell, hence explicitly
# setting bash instead of sh in the shebang.
#
if [ "$EUID" -ne 0 ]; then
	echo "Please run as root."
	exit
fi

#
# Update the information apt currently has about the remote apt repository
#
apt update

#
# Tell apt to install nginx from the remote repository
# making sure to add the -y flag as to not run the script
# to a halt at this step.
#
apt install nginx -y

#
# Explicitly start the Nginx service
#
systemctl start nginx.service

#
# Explicitly enable the Nginx service so that is it booted
# even after a system restart.
#
systemctl enable nginx.service

#
# Remove the default index-file provided by Nginx
#
rm /var/www/html/index*.html

#
# Create a new file called index.html
# NOTE: This and the previous step are kind of superfluous
# and could be removed with minor changes to the script.
#
touch /var/www/html/index.html

#
# Assign the value of whoami to a variable "name",
# used in the HTML below.
#
name=$(whoami)

#
# Write the following HTML to the index.html previously created.
#
printf "
<html>
<head>
	<title>Welcome, $name!</title>
	<style>
		body {
			display: grid;
			place-content: center;
			height: 100vh;
			margin: 0;
			font-family: sans-serif;
		}
	</style>
</head>
<body>
	<h1>$name</h1>
</body>
</html>
" > /var/www/html/index.html

#
# Print out a message informing the user that the web server has started.
#
echo "Your web server is now up and running!"
