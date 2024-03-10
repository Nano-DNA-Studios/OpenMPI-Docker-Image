# Use an official Ubuntu base image
FROM ubuntu:22.04 
# or 20.04

# Avoid prompts from aptddo
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    ssh \
    && rm -rf /var/lib/apt/lists/*

# Set the version of OpenMPI
ENV OPENMPI_VERSION=4.1.1

# Download and extract OpenMPI
RUN wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-${OPENMPI_VERSION}.tar.gz \
    && tar -xzf openmpi-${OPENMPI_VERSION}.tar.gz \
    && cd openmpi-${OPENMPI_VERSION} \
    && ./configure --prefix=/usr/local \
    && make all install

# Cleanup
RUN rm -rf openmpi-${OPENMPI_VERSION}.tar.gz openmpi-${OPENMPI_VERSION}

# Set environment variables
ENV PATH="/usr/local/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/lib:${LD_LIBRARY_PATH}"