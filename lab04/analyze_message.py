#!/usr/bin/env python3
"""Flag common phishing indicators in a local set of fictional messages."""

import json
import sys
from pathlib import Path


RED_FLAGS = {
    "urgency": ("urgent", "immediately", "within 24 hours", "suspended"),
    "secret_request": ("password", "card number", "security code", "one-time code"),
    "link_pressure": ("click here", "verify your account", "open the link"),
    "payment_pressure": ("payment failed", "refund", "bank details"),
}


def analyze(text: str) -> list[str]:
    lowered = text.casefold()
    return [
        label
        for label, indicators in RED_FLAGS.items()
        if any(indicator in lowered for indicator in indicators)
    ]


def main(path: Path) -> int:
    try:
        messages = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as error:
        print(f"Cannot read message examples: {error}", file=sys.stderr)
        return 1

    if not isinstance(messages, list) or not all(
        isinstance(item, dict) and isinstance(item.get("text"), str)
        for item in messages
    ):
        print("Expected a JSON array of objects with a text field.", file=sys.stderr)
        return 1

    for item in messages:
        flags = analyze(item["text"])
        label = ", ".join(flags) if flags else "no obvious indicator"
        print(f'{item.get("id", "message")}: {label}')
    return 0


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {Path(sys.argv[0]).name} MESSAGES.json", file=sys.stderr)
        raise SystemExit(2)
    raise SystemExit(main(Path(sys.argv[1])))
