FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    g++ build-essential openssl && rm -rf /var/lib/apt/lists/*

ADD cmake-3.11.1.tar.gz boost_1_67_0.tar.gz cpprestsdk-2.10.2-nmos-cpp.tar.gz \
    mDNSResponder-878.30.4.tar.gz nmos-cpp.tar.gz /home/

## no need to untar the ADD command does it for you
RUN cd /home/cmake* && ./bootstrap  && make && make install 
RUN cd /home/boost* && ./bootstrap.sh b2 --with-toolset=gcc --with-libraries=date_time,regex,system,thread \
    --prefix=. && ./b2
RUN cd /home/mDNSResponder*/mDNSPosix && make os=linux && make os=linux install

#WORKDIR /home/
#CMD ["/home/emset.sh", "run"]
