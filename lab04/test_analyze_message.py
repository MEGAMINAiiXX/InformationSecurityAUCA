import unittest

from analyze_message import analyze


class MessageAnalysisTests(unittest.TestCase):
    def test_flags_urgent_secret_request_and_link_pressure(self) -> None:
        flags = analyze("Urgent: click here to verify your account password.")
        self.assertEqual(["urgency", "secret_request", "link_pressure"], flags)

    def test_does_not_flag_neutral_text(self) -> None:
        self.assertEqual([], analyze("The library schedule is available on campus."))


if __name__ == "__main__":
    unittest.main()
