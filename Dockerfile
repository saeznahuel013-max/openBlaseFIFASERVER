FROM ubuntu:22.04
WORKDIR /app
COPY . .
# Este comando nos dirá en los logs qué archivos hay exactamente
CMD ls -R
