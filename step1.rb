require 'socket'

# STEP 1: Just listen for one request, serve it, and end.

# Open the wormhole
server = TCPServer.new('127.0.0.1', 9090)

# Someone wants to talk to us!
connection = server.accept()

# Read one line from the new connection
request = connection.gets()

# Log the line in terminal for reference
puts request

# Send a response
connection.print("HTTP/1.1 200 OK\r\n")
connection.print("Content-Type: text/html\r\n")
connection.print("\r\n")
connection.print("Thank you for requesting a webpage. Please enjoy.")

# Thanks guy! See ya later.
connection.close()
