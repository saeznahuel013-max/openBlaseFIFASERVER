# Usamos una imagen base completa con soporte para casi todo
FROM node:18-bullseye

# Instalamos Python, C++ y herramientas de red básicas
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copiamos todos los archivos del repositorio
COPY . .

# --- SCRIPT DE EJECUCIÓN UNIVERSAL ---
# Este comando busca qué tipo de proyecto es y lo lanza
CMD if [ -f "package.json" ]; then \
        echo "Detectado: Node.js" && npm install && npm start; \
    elif [ -f "main.py" ] || [ -f "server.py" ]; then \
        echo "Detectado: Python" && python3 $(ls main.py server.py 2>/dev/null | head -n 1); \
    elif [ -f "index.js" ]; then \
        echo "Detectado: Node.js (directo)" && node index.js; \
    elif [ -f "Makefile" ]; then \
        echo "Detectado: C/C++ (Makefile)" && make && ./$(ls -F | grep '*' | head -n 1); \
    else \
        echo "No se detectó archivo estándar. Listando archivos y esperando..." && ls -R; \
    fi
