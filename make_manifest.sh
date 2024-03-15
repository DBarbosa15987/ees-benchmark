#!/usr/bin/env bash
BENCH_SRC="benches"
BENCH_MANIFEST="$BENCH_SRC/MANIFEST"

printf "[benchmark]\n\n" > $BENCH_MANIFEST
printf "name\tmetafile\n" >> $BENCH_MANIFEST

for f in "$BENCH_SRC"/*; do
    name=$(echo "$f" | cut -d '/' -f 2)
    if [ -d "$f" ]; then
        printf "%s\t%s\n" "$name" "./$f" >> $BENCH_MANIFEST
    fi
done
