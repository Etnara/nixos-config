{ pkgs, ... }:

pkgs.mkShell {

  packages = with pkgs; [
    gcc
    cargo
    temurin-bin # Java
    php
    phpPackages.composer
    (python3.withPackages (pp: with pp; [
      numpy
      torch # use `torch-bin` for CUDA support, compilation takes a long time
      pandas
      polars
      transformers
      spacy # Can't download 
      # gensim
      scikit-learn
      matplotlib
      selenium
      flask
      mariadb
      redis
      pymongo
      neo4j
    ]))
  ];

}

