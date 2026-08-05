#!/usr/bin/env python3
"""
Simple log shipper: tails a file and prefixes each new line with a timestamp.
Usage: python3 log_shipper.py /var/log/nginx/access.log
"""
import sys
import time
from datetime import datetime, timezone


def tail(path):
    with open(path, "r") as f:
        f.seek(0, 2)  # seek to end of file, only ship new lines
        while True:
            line = f.readline()
            if not line:
                time.sleep(0.5)
                continue
            timestamp = datetime.now(timezone.utc).isoformat()
            print(f"[{timestamp}] {line.rstrip()}", flush=True)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: log_shipper.py <path-to-file>", file=sys.stderr)
        sys.exit(1)

    file_path = sys.argv[1]
    try:
        tail(file_path)
    except KeyboardInterrupt:
        sys.exit(0)
    except FileNotFoundError:
        print(f"File not found: {file_path}", file=sys.stderr)
        sys.exit(1)