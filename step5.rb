require 'socket'

# STEP 5: Correctly return 404 for favicon requests.

def log_connection(request_headers, response)
    print <<-EOF.gsub(/^ {8}/, "")
        ==================================
        ====== NEW REQUEST INCOMING ======
        ==================================

        ------ REQUEST -------------------
    EOF
    print request_headers
    print <<-EOF.gsub(/^ {8}/, "")
        \n----------------------------------

        ------ RESPONSE ------------------
    EOF
    print response
    print "\n----------------------------------\n\n"
end

EMPTY_LINE = /^\s*$/

server = TCPServer.new('127.0.0.1', 9090)

while connection = server.accept()

    lines = []
    while line = connection.gets and line !~ EMPTY_LINE
        lines << line.chomp
    end

    method, path, protocol = lines[0].split(" ")
    request_headers = lines.join("\n")

    response_code = '200 OK'

    response_body = case path
    when '/favicon.ico'
        response_code = '404 Not Found'
        "Sorry! No favicon, pal."
    else
        "I am an awful webserver and have absolutely no idea what #{path} is."
    end

    # Don't set the headers until we've handled the method and path,
    # because we might be changing the response code.
    response_headers = <<-EOF.gsub(/^ */, "")
        HTTP/1.1 #{response_code}\r
        Content-Type: text/html\r
    EOF

    response = response_headers + "\r\n" + response_body

    connection.write(response)
    connection.close()

    log_connection(request_headers, response)

end
