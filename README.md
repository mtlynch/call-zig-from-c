# call-zig-from-c

Simple example of creating a Zig library you can call from C.

## References

https://stackoverflow.com/q/64451405/90388

## Process

```bash
zig init-lib
```

Change to shared lib

Add _ = lib.getEmittedH();

```bash
mkdir -p bin
```

```bash
gcc \
  -I /nix/store/bg6hyfzr1wzk795ii48mc1v15bswcvp3-zig-0.11.0/lib/zig/ \
  -I zig-cache/ \
  -D ZIG_TARGET_MAX_INT_ALIGNMENT=1 \
  -Lzig-out/lib/ \
  -lcall-zig-from-c \
  c-src/test.c \
  -o ./bin/test

LD_LIBRARY_PATH=zig-out/lib/:$LD_LIBRARY_PATH ./bin/test
```
