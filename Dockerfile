# Usamos una imagen de Ubuntu con herramientas de compilación
FROM ubuntu:22.04

# Instalamos dependencias de C++ y herramientas necesarias
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copiamos los archivos del repo
COPY . .

# Compilamos (asumiendo que usa CMake, que es lo común en openBlase)
RUN mkdir build && cd build && cmake .. && make

# Comando para ejecutar el servidor
# Ajusta "openBlase" al nombre del ejecutable que genere la compilación
CMD ["./build/openBlase"]
