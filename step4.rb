require 'socket'

# STEP 4: Read an entire GET request and log it to terminal.

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
    print "----------------------------------\n\n"
end

EMPTY_LINE = /^\s*$/

server = TCPServer.new('127.0.0.1', 9090)

while connection = server.accept()

    # Keep reading until we hit an empty line
    lines = []
    while line = connection.gets and line !~ EMPTY_LINE
        lines << line.chomp
    end

    method, path, protocol = lines[0].split(" ")
    request_headers = lines.join("\n")

    response = <<-EOF.gsub(/^ */, "") # trim leading spaces
        HTTP/1.1 200 OK\r
        Content-Type: text/html\r
        \r
        I am an awful webserver and have absolutely no idea what #{path} is.
    EOF

    connection.write(response)
    connection.close()

    log_connection(request_headers, response)

end
