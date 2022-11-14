FROM pytorch/pytorch
RUN apt update && apt install build-essential git cmake -y && conda install cudnn
RUN git clone https://github.com/facebookresearch/jps.git && cd jps && git submodule update --init --recursive
RUN cd jps/simple_game && mkdir build && cd build && cmake .. && make
RUN apt update && apt install wget -y
RUN pip install pandas
ENTRYPOINT [ "./jps" ]