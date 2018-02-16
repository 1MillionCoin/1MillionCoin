##################################  Notes  ##################################
# build:
#   docker build --no-cache -t 1millioncoin .
#
# run:
#   docker run -it -p 15015:15015 1millioncoin
#
# run with a mounted directory for ~/.1MillionCoin:
#   docker run -it -p 15015:15015 -v /path/to/a/local/directory:/root/.1MillionCoin 1millioncoin
#
# run will exec you into docker /bin/bash
# from there, you can run:
# 1millioncoind # starts the 1millioncoin deamon
#
# For accessing the 1millioncoin JSON-RPC api from the host:
# 1. Expose RPC port in when running docker
#    docker run -it -p 15015:15015 -p 5000:XXX -v /path/to/a/local/directory:/root/.1MillionCoin 1millioncoin # Replace XXX with set rpcPort in 1millioncoin.conf
# 2. From host access the API via:
# `curl --user rpc_user:rpc_pass --data '{"method": "getinfo"}' http://127.0.0.1:5000`
#############################################################################

FROM ubuntu:16.04

# Build essentials
RUN apt-get install git build-essential libboost1.58-all-dev libssl-dev libdb5.3++-dev libminiupnpc-dev

RUN apt-get clean

RUN git clone https://github.com/1MillionCoin/1MillionCoin.git 1MillionCoin && cd 1MillionCoin/src/ && make -f makefile.unix && cp 1millioncoind /usr/local/sbin/1millioncoind

RUN mkdir /root/.1MillionCoin/

CMD ["/bin/bash"]
