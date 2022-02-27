import sys
import socket
import threading
import traceback
import time

from server import HOST

HOST = "127.0.0.1"
PORT = 5678


def handle_content(content):
    print("receive server data: " + content)

def server_receive(client_socket, nothing):
    client_on = True

    while client_on:
        try:
            data = client_socket.recv(1024)
            # if not data:
            #     break
            content = data.decode('UTF-8')
            handle_content(content)

        except Exception as ex:
            traceback.print_exc()
            print("read catch exception:", ex)


def run():
    global HOST
    global PORT
    
    if(len(sys.argv) > 1):
        HOST = sys.argv[1]
    if len(sys.argv) > 2:
        PORT = int(sys.argv[2])

    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((HOST, PORT))

    server_thread=threading.Thread(name="ServerHandler", target=server_receive, args=(client_socket, ""))
    server_thread.daemon=True
    server_thread.start()

    while 1:
        word = input("Enter your word:")
        if word == 'q' :
            break
        client_socket.send(word.encode())


if __name__ == '__main__':
    run()