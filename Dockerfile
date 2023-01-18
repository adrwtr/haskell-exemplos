FROM haskell:8.10

RUN mkdir -p /src
WORKDIR /src

# docker run --rm --interactive --tty --volume $PWD:/src  haskell
# :load src/src/ nome arquivo