import os
import tempfile
import unittest
from pathlib import Path

from toy_shell import list_items_older_than


class ToyShellTests(unittest.TestCase):
    def test_lists_only_entries_modified_before_target_date(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            old_file = root / "old.txt"
            recent_file = root / "recent.txt"
            old_file.write_text("old", encoding="utf-8")
            recent_file.write_text("recent", encoding="utf-8")
            os.utime(old_file, (0, 0))

            results = list_items_older_than("2001-01-01", root)

            self.assertEqual(1, len(results))
            self.assertTrue(results[0].startswith("old.txt (File"))

    def test_rejects_invalid_date(self) -> None:
        with self.assertRaisesRegex(ValueError, "YYYY-MM-DD"):
            list_items_older_than("not-a-date")

    def test_requires_hyphenated_date_format(self) -> None:
        with self.assertRaisesRegex(ValueError, "YYYY-MM-DD"):
            list_items_older_than("20010101")


if __name__ == "__main__":
    unittest.main()
