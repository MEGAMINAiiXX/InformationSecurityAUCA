#!/usr/bin/env python3
"""Append one local timestamp to an explicitly selected output file."""

import sys
from datetime import datetime
from pathlib import Path


def main() -> int:
    if len(sys.argv) != 2:
        print(f"Usage: {Path(sys.argv[0]).name} OUTPUT_FILE", file=sys.stderr)
        return 2

    output = Path(sys.argv[1])
    try:
        with output.open("a", encoding="utf-8") as file:
            file.write(datetime.now().astimezone().isoformat(timespec="seconds") + "\n")
    except OSError as error:
        print(f"Cannot write timestamp: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
