{ pkgs, ... }:

pkgs.mkShell {

  packages = with pkgs; [
    gcc
    cargo
    temurin-bin # Java
    (python3.withPackages (pp: with pp; [
      numpy
      torch
      pandas
      polars
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

