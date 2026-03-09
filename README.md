# Baseline interpreters for https://github.com/pex-tool/pex/issues/3113

To build the interpreters, run `docker build .`.

For example:
```console
# Build the interpreters:
:; docker build . -t pex-issues-3113

# Now examine them:
:; docker run --rm pex-issues-3113 /examine-pythons.sh
8d3340e69b4006ca106b74811fe178ec098b6cec139719b9607360200e77f49b  /opt/python/3.14.0/bin/python3.14
/opt/python/3.14.0/bin/python3.14: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, stripped
d4f9478e5bc5c562be0e82d2885130e54acbe721d1e4e943d13c327662a2285b  /opt/python/3.14.0/lib/libpython3.14.so.1.0
/opt/python/3.14.0/lib/libpython3.14.so.1.0: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, with debug_info, not stripped
0dd107c3eec2f1f078231152d0cd8ef3785eddde1c8f9b12ad559967f67c6a1a  /opt/python/3.14.2/bin/python3.14
/opt/python/3.14.2/bin/python3.14: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, stripped
5bd303ef71d4d894a4bff9010bd4febd148213f79e4c953e216ee0db049bc863  /opt/python/3.14.2/lib/libpython3.14.so.1.0
/opt/python/3.14.2/lib/libpython3.14.so.1.0: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, with debug_info, not stripped
0389497f5336903762724d4693660429efd468eac887038ea5bbae27047bd84f  /opt/python/3.14.3/bin/python3.14
/opt/python/3.14.3/bin/python3.14: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, stripped
beea750e09e45f0ed4c5f447407c2ed453b0b4b0e70dc89fcec9fd04ea526c62  /opt/python/3.14.3/lib/libpython3.14.so.1.0
/opt/python/3.14.3/lib/libpython3.14.so.1.0: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, with debug_info, not stripped
```

There should be at least 2 interpreters of different versions built that have python binaries with
the same hash (Currently this is not the case - all hashes differ).
