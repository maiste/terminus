<div align="center">
  <h1>Terminus</h1>
  <br />
  <strong>Another Rest API http client manager, written in OCaml</strong>
</div>

<hr />

## About

This package gives a specification about a REST API Backend to execute requests to a web API using JSON format to interact with. `terminus` also gives implementations of this specification with different ocaml http client. It was first written as a part of the `equinoxe` package but, as I tend to use it more other projects, it seems a good idea to extract it as a package itself.

:warning: Be aware that this is still an under development package. The API can change regularly until there is a fix version of the API.

## Getting started

### Installation

To install a `dev` version of _Terminus_, you can install it via pinning:
```
$ opam pin add terminus.dev https://github.com/maiste/terminus.git
```

To install the last version:
```
opam install terminus
```


### Usage

_Terminus_ contains two types of modules. The first one is the `Terminus` module which contains the specifications for an REST API backend. The other ones are `Terminus-*` which implement this specification with an ocaml http client.

## Documentation

API documentation can be found online on the [project GitHub Pages](https://maiste.github.io/terminus)
