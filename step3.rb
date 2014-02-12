require 'socket'

server = TCPServer.new('127.0.0.1', 9090)

while session = server.accept()

    request = session.gets()
    puts request

    method, path, protocol = request.split(" ")

    session.print("HTTP/1.1 200/OK\r\n")
    session.print("Content-type: text/html\r\n")
    session.print("\r\n")
    session.print("I am an awful webserver and have absolutely no idea what #{path} is.")

    session.close()

end
