FROM ssages/pysages-hoomd:latest

COPY . openmm-dlext
RUN cd openmm-dlext && mkdir build && cd build && cmake .. && make install
RUN python -c "import openmm_dlext"
