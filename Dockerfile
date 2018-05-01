FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    g++ build-essential openssl libssl-dev && rm -rf /var/lib/apt/lists/*

ADD cmake-3.11.1.tar.gz boost_1_67_0.tar.gz cpprestsdk-2.10.2-nmos-cpp.tar.gz \
    mDNSResponder-878.30.4.tar.gz nmos-cpp.tar.gz /home/

## no need to untar the ADD command does it for you
RUN cd /home/cmake* && ./bootstrap  && make && make install 
RUN cd /home/boost* && ./bootstrap.sh b2 --with-toolset=gcc --with-libraries=date_time,regex,system,thread,random,filesystem,chrono,atomic \
    --prefix=. && ./b2
RUN cd /home && patch -d mDNSResponder-878.30.4/ -p1 <nmos-cpp/Development/third_party/mDNSResponder/poll-rather-than-select.patch
RUN cd /home/mDNSResponder*/mDNSPosix && set HAVE_IPV6=0 && make os=linux && make os=linux install

#Build C++ REST SDK
RUN mkdir /home/cpprestsdk-2.10.2-nmos-cpp/Release/build && \
    cd /home/cpprestsdk*/Release/build && \
    cmake .. \
   -DCMAKE_BUILD_TYPE:STRING="Release" \
   -DWERROR:BOOL="0" \
   -DBOOST_INCLUDEDIR:PATH="/home/boost_1_67_0" \
   -DBOOST_LIBRARYDIR:PATH="/home/boost_1_67_0/x64/lib" \
   -DOPENSSL_ROOT_DIR="/usr/lib/x86_64-linux-gnu" \
   -DOPENSSL_LIBRARIES="/usr/lib/x86_64-linux-gnu" && \
   make && \
   make install

#Build nmos-cpp
#RUN cd /home/nmos-cpp/Development && mkdir build && 
#WORKDIR /home/
#CMD ["/home/emset.sh", "run"]
