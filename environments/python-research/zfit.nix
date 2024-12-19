{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  setuptools_scm,
  setuptools_scm_git_archive,
}:

buildPythonPackage rec {
  pname = "zfit";
  version = "0.24.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "6b83315e16e07d8472d92b142b377d8d7314411d27fe8033168037fd4583f5f6";
  };

  doCheck = false;
  pyproject = true;
  build-system = [
    setuptools
    setuptools_scm
    wheel
    setuptools_scm_git_archive
  ];
}
