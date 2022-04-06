import sys
import socket
import threading
import traceback
import time

HOST = '127.0.0.1'
PORT = 5678

def handle_content(content):
    print("receive from client : " + content)
    return "[" + content + "]"

def recv_process(conn, addr):
    client_on = True

    while client_on:
        try:
            data = conn.recv(1024)
            if not data:
                break
            content = data.decode('UTF-8')
            res = handle_content(content)
            conn.send(res.encode())

        except Exception as ex:
            client_on = False
            traceback.print_exc()
            print("read catch exception:", ex)

def server_wait_thread():

    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    # Bind socket to local host and port
    try:
        server_socket.bind((HOST, PORT))
    except socket.error as msg:
        print(f"Band failed. Error code: {msg[0]} Message {msg[1]}")
        sys.exit()

    #  5 here means that 5 connections can be kept. 
    # If the server is busy for 5 connections and a 6th socket tries to connect, 
    # then the connection is refused.
    server_socket.listen(5)

    print("Server started.")

    while 1:
        try:
            # wait to accept a connection - blocking call
            conn, addr = server_socket.accept()

            # start new thread takes 1st arg as a function to be run,
            # second is the tuple of arguments to the function.
            process_thread = threading.Thread(name = "Handler", target=recv_process, args=(conn, addr))
            process_thread.daemon = True
            process_thread.start()
            print("One client connected.")
        except Exception as e:
            print("accept catch exception:", e)
    server_socket.close()

def run():
    global PORT
    if(len(sys.argv) > 1):
        PORT = int(sys.argv[1]) # use the first arg as port

    # start a thread to run server, so the main thread can recieve terminal kill
    server_thread = threading.Thread(name = "ServerHandler", target=server_wait_thread)
    server_thread.daemon = True
    server_thread.start()
    while 1:
        time.sleep(1)
        

if __name__ == '__main__':
    run()