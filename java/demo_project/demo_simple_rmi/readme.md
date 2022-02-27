
# 编译
javac -d classes -encoding utf8 server/*.java client/*.java

# 启动 server
java -cp classes server/RmiServer

# 运行 client
java -cp classes client/RmiClient