##let
##  # use a specific (although arbitrarily chosen) version of the Nix package collection
##  default_pkgs = fetchTarball {
##    url = "http://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
##    sha256 = "1h0y7gxndl3a06h0cq0k4kbbhq5jhvgh6jqzvc5qprlyakj1khhj";
##  };
### function header: we take one argument "pkgs" with a default defined above
##in { pkgs ? import default_pkgs { } }:
{ pkgs ? import <nixpkgs> { } }:
with pkgs;
with lib;
with cmake;
let
  myPyPkgsV = python310Packages.override {
    overrides = self: super: {

      skimage = super.buildPythonPackage rec {
        pname = "scikit-image" ;
        version = "0.22.0" ;
        src = super.fetchPypi {
          inherit pname version;
          sha256 = "1nqvlljpkdrgmc3ibac27y57r7w1sg7mhyfq3v1vaka2gmqf3z23";
        };
        doCheck = false;
        buildInputs = with super;
          [ numpy pandas scipy networkx pillow imageio tifffile packaging ];
      };
    };
  };

  myPyPkgs = python39Packages.override {

    overrides = self: super: {

      devimp = super.buildPythonPackage rec {
        name = "myimp";
        version = "DEV";
        src = /home/rictjo/Dev/python/impetuous;
        buildInputs = with super;
          [ numpy pandas scipy scikit-learn statsmodels ];
      };

      myforest = super.buildPythonPackage rec {
        name = "missingpy";
        version = "DEV";
        src = /home/rictjo/Dev/python/missingpy;
        buildInputs = with super;
          [ numpy scipy scikit-learn ];
      };


     missforest = super.buildPythonPackage rec {
        pname = "missingpy";
        version = "0.2.0";
        src = super.fetchPypi {
          inherit pname version;
          sha256 = "Wqz1tEDkQ6HNHrBLoWhAKnoIw+xYadKwEw2NI12GEcE=";
        };
        doCheck = false;
        buildInputs = with super;
          [ numpy scipy myPyPkgs.oscikit ]; # scikit-learn ];
     };
     # numpy==1.15.4
     # scipy==1.1.0
     # scikit-learn==0.20.1

    };
  };
  #
  pythonBundle =
    python39.withPackages (ps: with ps; [ 
      numba scikit-learn matplotlib numpy 
      ipython statsmodels kmapper
      bokeh hvplot holoviews plotly 
      beautifulsoup4 rpy2
      matplotlib bokeh seaborn
      hvplot holoviews
      datashader param colorcet
      panel pillow openpyxl imageio
      umap-learn graphviz plotly dash
      pyspark pytorch networkx flask

      python-igraph ruamel-yaml

      jaxlib jax
      # test
      bison toml
      pytest pytest-cov codecov
      black memory_profiler

      xgboost
      #kaleido

 ]);

in mkShell { buildInputs = [ pythonBundle myPyPkgs.myforest ]; }
