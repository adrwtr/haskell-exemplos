FROM haskell:8.10

RUN mkdir -p /src
WORKDIR /src

WORKDIR /opt/example

RUN cabal update

# Add just the .cabal file to capture dependencies
COPY ./src/todogtk.cabal /opt/example/example.cabal

# Docker will cache this command as a layer, freeing us up to
# modify source code without re-installing dependencies
# (unless the .cabal file changes!)
# RUN cabal build --only-dependencies -j4

# Add and Install Application Code
# COPY . /opt/example
# RUN cabal install

# CMD ["example"]

# CMD ["haskell"]
# docker run --rm --interactive --tty --volume $PWD:/src  haskell
# :load src/src/ nome arquivo