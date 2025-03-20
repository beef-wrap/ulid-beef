mkdir libs
mkdir libs\debug
mkdir libs\release

clang -c -O0 -g -gcodeview -o ulid.lib -target x86_64-pc-windows -fuse-ld=llvm-lib -Wall -Dulid_IMPL ulid-c\ulid.c
move ulid.lib libs\debug

clang -c -O3 -o ulid.lib -target x86_64-pc-windows -fuse-ld=llvm-lib -Wall -Dulid_IMPL ulid-c\ulid.c
move ulid.lib libs\release