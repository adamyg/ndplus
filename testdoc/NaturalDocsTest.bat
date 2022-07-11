@echo off
mkdir HTMLOutput
perl ..\bin\NaturalDocs -t 8 -s  -s Default Extra test -o FramedHTML HTMLOutput -r --documented-only -p . -i src

