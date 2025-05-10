#!/usr/bin/env bash
set -e

# the Python entry-point you want to compile
SCRIPT="bot.py"

# make sure Nuitka is installed
pip3 install --user nuitka

# list of architectures (folders you have)
ARCHS=(i486 i586 i686 m68k mips mipsel powerpc sh4 sparc \
       armv4l armv5l armv6l armv7l powerpc-440fp x86_64)

for arch in "${ARCHS[@]}"; do
  TC_DIR="./$arch/bin"
  CC="$TC_DIR/${arch}-gcc"
  CXX="$TC_DIR/${arch}-g++"

  if [[ ! -x "$CC" ]]; then
    echo "⚠️  Skipping $arch — compiler not found at $CC"
    continue
  fi

  echo "🔨 Building for $arch…"

  # create per-arch output dir
  OUTDIR="build-$arch"
  mkdir -p "$OUTDIR"

  # drive Nuitka with your cross-compiler
  CC="$CC" CXX="$CXX" \
    python3 -m nuitka \
      --standalone \
      --onefile \
      --output-dir="$OUTDIR" \
      "$SCRIPT"

  echo "✅ Done: $OUTDIR/$(basename "$SCRIPT" .py)"
done
