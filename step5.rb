require 'socket'

def html_template(body)
    <<-EOF
    <!doctype html>
    <html>
        <head>
            <title>Signup List</title>
        </head>
        <body>
        #{body}
        </body>
    </html>
    EOF
end

def response(path, signup_list)
    return html_template("Current signups: #{signup_list.join(', ')}")
end

def run_server()
    server = TCPServer.new('127.0.0.1', 9090)

    signup_list = ["Max"]

    while session = server.accept()

        request = session.gets()
        puts request

        method, path, protocol = request.split(" ")

        session.print("HTTP/1.1 200/OK\r\n")
        session.print("Content-Type: text/html\r\n")
        session.print("\r\n")
        session.print(response(path, signup_list))

        session.close()

    end
end

if __FILE__ == $0
    run_server()
end
