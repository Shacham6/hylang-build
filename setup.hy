(import [setuptools[setup find_packages]])


(setup :name "hylang_build"
       :version "0.0.1"
       :author "Ajo"
       :packages (find_packages :exclude ["tests"])
       :install-requires [
           "hy"
           "pathlib" 
       ])
