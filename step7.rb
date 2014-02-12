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
        html_signup_form
    )
end

def extract_headers(session)
    headers = {}

    while line = session.gets()
        header, value = line.split(": ")

        case header
        when "Content-Length"
            headers[header] = value.to_i
        else
            headers[header] = value
        end

        break if line == "\r\n"
    end

    return headers
end

def extract_post_data(session, content_length)
    data = {}

    raw = session.read(content_length)

    raw.split("\n").each do |line|
        key, data[key] = line.split("=", 2)
    end

    return data
end

def run_server
    server = TCPServer.new('127.0.0.1', 9090)

    signup_list = ["Max"]

    while session = server.accept()

        request = session.gets()
        puts request

        method, path, protocol = request.split(" ")

        headers = extract_headers(session)

        if method == "POST"
            data = extract_post_data(session, headers['Content-Length'])
            signup_list.push(data['new_name'])
        end

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
