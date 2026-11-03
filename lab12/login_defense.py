#!/usr/bin/env python3
"""A local-only demonstration of temporary lockout after failed logins."""


MAX_ATTEMPTS = 3
DEMO_USERNAME = "demo"
DEMO_PASSWORD = "not-a-real-account"


def main() -> None:
    failures = 0
    print("Local simulation only. Use the fictional demo values shown in the source.")
    while failures < MAX_ATTEMPTS:
        username = input("Username: ")
        password = input("Password: ")
        if username == DEMO_USERNAME and password == DEMO_PASSWORD:
            print("Demo login accepted.")
            return

        failures += 1
        remaining = MAX_ATTEMPTS - failures
        if remaining:
            print(f"Invalid demo credentials. Attempts remaining: {remaining}")

    print("Demo account temporarily locked after repeated failures.")


if __name__ == "__main__":
    main()
