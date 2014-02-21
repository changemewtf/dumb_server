require 'socket'

def response(request)
    method, path, protocol = request.split(" ")

    return "I am an awful webserver and have absolutely no idea what #{path} is."
end

def run_server()
    server = TCPServer.new('127.0.0.1', 9090)

    while session = server.accept()

        request = session.gets()
        puts request

        session.print("HTTP/1.1 200/OK\r\n")
        session.print("Content-Type: text/html\r\n")
        session.print("\r\n")
        session.print(response(request))

        session.close()

    end
end

if __FILE__ == $0
    run_server()
end
