FROM crystallang/crystal:1.13.2

WORKDIR /app

# Add llvm deps.
RUN apt install llvm15-dev llvm15-static g++ libxml2-static make

# Build crystalline.
COPY . /app/

RUN git clone -b 1.13.2 --depth=1 https://github.com/crystal-lang/crystal \
      && make -C crystal llvm_ext \
      && CRYSTAL_PATH=crystal/src:lib shards build crystalline \
      --no-debug --progress --stats --production --static --release \
      -Dpreview_mt --ignore-crystal-version \
      && rm -rf crystal
