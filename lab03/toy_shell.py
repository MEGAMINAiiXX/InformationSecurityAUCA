#!/usr/bin/env python3
"""A small shell-like prompt for listing items modified before a date."""

from datetime import date, datetime
from pathlib import Path


def list_items_older_than(
    date_input: str, directory: Path | None = None
) -> list[str]:
    """Return display lines for entries whose modification date precedes date_input."""
    try:
        target_date = datetime.strptime(date_input, "%Y-%m-%d").date()
    except ValueError:
        raise ValueError("Invalid date format. Please use YYYY-MM-DD.") from None

    if directory is None:
        directory = Path.cwd()

    matches: list[str] = []
    for item in sorted(directory.iterdir()):
        modified = datetime.fromtimestamp(item.stat().st_mtime)
        if modified.date() < target_date:
            item_type = "Folder" if item.is_dir() else "File"
            matches.append(
                f"{item.name} ({item_type}, Modified: {modified:%Y-%m-%d %H:%M:%S})"
            )
    return matches


def toy_shell() -> None:
    print("Toy Shell: list current-directory items modified before a date.")
    print("Enter YYYY-MM-DD, or type 'exit' to quit.")
    while True:
        try:
            command = input("toy-shell> ").strip()
        except (EOFError, KeyboardInterrupt):
            print("\nExiting toy shell.")
            return

        if command.lower() == "exit":
            print("Exiting toy shell.")
            return

        try:
            results = list_items_older_than(command)
        except ValueError as error:
            print(error)
            continue

        if results:
            print("\n".join(results))
        else:
            print("No matching items.")


if __name__ == "__main__":
    toy_shell()
