import unittest

from password_policy import check_password


class PasswordPolicyTests(unittest.TestCase):
    def test_short_password_is_rejected(self) -> None:
        self.assertIn("Use at least 14 characters.", check_password("short"))

    def test_common_example_is_rejected(self) -> None:
        issues = check_password("password123")
        self.assertIn("Avoid common example passwords.", issues)

    def test_personal_term_is_rejected_case_insensitively(self) -> None:
        issues = check_password("Alex-Long-Test-Password", ("alex",))
        self.assertIn("Avoid names, dates, and other personal information.", issues)

    def test_long_unmatched_example_passes_basic_checks(self) -> None:
        self.assertEqual([], check_password("fictional-river-window-47"))


if __name__ == "__main__":
    unittest.main()
