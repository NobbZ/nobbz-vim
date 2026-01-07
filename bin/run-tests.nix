{
  self,
  python3,
  writeShellScriptBin,
}:
writeShellScriptBin "run-tests" ''
  exec ${python3}/bin/python3 ${self}/bin/run-tests.py "$@"
''
