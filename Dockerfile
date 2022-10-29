FROM pytorch/pytorch
RUN apt update && apt install build-essential git cmake -y && conda install cudnn
RUN git clone https://github.com/facebookresearch/jps.git && cd jps && git submodule update --init --recursive
RUN cd jps/simple_game && mkdir build && cd build && cmake .. && make

WORKDIR /workspace/jps/simple_game/build