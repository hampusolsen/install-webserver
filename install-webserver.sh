#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root."
	exit
fi

read -p "Please input your name: "

apt update -y
apt install nginx -y

systemctl start nginx.service
systemctl enable nginx.service

rm /var/www/html/index*.html
touch /var/www/html/index.html

printf "
<html>
<head>
	<title>Welcome, $REPLY!</title>
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
	<h1>$REPLY</h1>
</body>
</html>
" > /var/www/html/index.html

echo "Your web server is now up and running!"
