require 'socket'

server = TCPServer.new('127.0.0.1', 9090)

session = server.accept()

request = session.gets()
puts request

session.print("HTTP/1.1 200/OK\r\n")
session.print("Content-type: text/html\r\n")
session.print("\r\n")
session.print("Thank you for requesting a webpage. Please enjoy.")

session.close()
