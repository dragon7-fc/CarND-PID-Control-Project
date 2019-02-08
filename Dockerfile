FROM dragon7/carnd-path-planning-project

# Install CarND-PID-Control-Project
WORKDIR /root/workspace
COPY ./ CarND-PID-Control-Project/

# Create Eclipse IDE project
WORKDIR /root/workspace/CarND-PID-Control-Project
RUN mkdir build
RUN mv CMakeLists.txt src
RUN sed -i 's/src/./g' src/CMakeLists.txt
WORKDIR /root/workspace/CarND-PID-Control-Project/build
RUN cmake -G"Eclipse CDT4 - Unix Makefiles" -D CMAKE_BUILD_TYPE=Debug ../src/
RUN make

WORKDIR /root/workspace
