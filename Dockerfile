FROM pytorch/pytorch AS Source
RUN apt update && apt install build-essential git cmake -y && conda install cudnn
RUN git clone https://github.com/facebookresearch/jps.git && cd jps && git submodule update --init --recursive
RUN cd jps/simple_game && mkdir build && cd build && cmake .. && make


FROM pytorch/pytorch
COPY --from=Source /workspace/jps/simple_game/build .
COPY --from=Source /workspace/jps/simple_game/load_strategies.py .
COPY --from=Source /workspace/jps/compute_score.py .
RUN apt update && apt install wget -y
RUN pip install pandas
ENTRYPOINT [ "./jps" ]