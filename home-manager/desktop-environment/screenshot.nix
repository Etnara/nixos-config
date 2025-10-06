{ pkgs, ... }:

{

  home.packages = with pkgs; [
    grim # Screenshot
    slurp # Screen Selection
    grimblast # grim + slurp tool
  ];

}

