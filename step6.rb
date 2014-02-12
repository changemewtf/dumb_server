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

def html_signup_form()
    <<-EOF
    <form method='POST' action='/'>
        <label for='new_name'>Name:</label>
        <input type='text' id='new_name' name='new_name' />
        <button type='submit'>Submit</button>
    </form>
    EOF
end

def html_name_list(signup_list)
    "<div>Current signups: #{signup_list.join(', ')}</div>"
end

def response(path, signup_list)
    return html_template(
        html_name_list(signup_list) +
        html_signup_form()
    )
end

def run_server
    server = TCPServer.new('127.0.0.1', 9090)

    signup_list = ["Max"]

    while session = server.accept()

        request = session.gets()
        puts request

        method, path, protocol = request.split(" ")

        session.print("HTTP/1.1 200/OK\r\n")
        session.print("Content-type: text/html\r\n")
        session.print("\r\n")
        session.print(response(path, signup_list))

        session.close()

    end
end

if __FILE__ == $0
    run_server()
end
