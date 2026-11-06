CREATE USER 'tom-maverick'@'localhost' IDENTIFIED VIA unix_socket;
GRANT ALL PRIVILEGES ON *.* TO 'tom-maverick'@'localhost';
FLUSH PRIVILEGES;
