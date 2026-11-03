#!/usr/bin/env python3
"""Check a user-entered password for a few basic defensive policy rules."""

import argparse
import getpass


COMMON_EXAMPLES = {"password", "password123", "qwerty123", "123456789"}


def check_password(password: str, personal_terms: tuple[str, ...] = ()) -> list[str]:
    issues: list[str] = []
    if len(password) < 14:
        issues.append("Use at least 14 characters.")
    if password.casefold() in COMMON_EXAMPLES:
        issues.append("Avoid common example passwords.")
    if any(term and term.casefold() in password.casefold() for term in personal_terms):
        issues.append("Avoid names, dates, and other personal information.")
    return issues


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--hint",
        action="append",
        default=[],
        help="fictional personal detail to check for; may be supplied more than once",
    )
    args = parser.parse_args()

    password = getpass.getpass("Enter a fictional test password (input is hidden): ")
    issues = check_password(password, tuple(args.hint))
    if issues:
        print("Review these suggestions:")
        for issue in issues:
            print(f"- {issue}")
        return 1

    print("No basic policy issue detected; this is not a guarantee of password strength.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
