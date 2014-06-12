require 'socket'

# STEP 3: Keep serving requests until Ctrl-C'd out of.

server = TCPServer.new('127.0.0.1', 9090)

while connection = server.accept()

    request = connection.gets()
    puts request

    method, path, protocol = request.split(" ")

    connection.print("HTTP/1.1 200 OK\r\n")
    connection.print("Content-Type: text/html\r\n")
    connection.print("\r\n")
    connection.print("I am an awful webserver and have absolutely no idea what #{path} is.")

    connection.close()

end
