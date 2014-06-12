require 'socket'

# STEP 2: Get the path from the first line of the request.

server = TCPServer.new('127.0.0.1', 9090)

connection = server.accept()

request = connection.gets()
puts request

# 'GET /index.html HTTP/1.1' => ['GET', '/index.html', 'HTTP/1.1']
method, path, protocol = request.split(" ")

connection.print("HTTP/1.1 200 OK\r\n")
connection.print("Content-Type: text/html\r\n")
connection.print("\r\n")
connection.print("I am an awful webserver and have absolutely no idea what #{path} is.")

connection.close()
