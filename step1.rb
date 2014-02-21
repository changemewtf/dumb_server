require 'socket'

# Open the wormhole
server = TCPServer.new('127.0.0.1', 9090)

# Someone wants to talk to us!
session = server.accept()

# Read one line from the new connection
request = session.gets()

# Log the line in terminal for reference
puts request

# Send a response
session.print("HTTP/1.1 200/OK\r\n")
session.print("Content-Type: text/html\r\n")
session.print("\r\n")
session.print("Thank you for requesting a webpage. Please enjoy.")

# Thanks guy! See ya later.
session.close()
