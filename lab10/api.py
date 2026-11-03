#!/usr/bin/env python3
"""Local-only sample API for the NGINX reverse-proxy exercise."""

import json
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer


class Handler(BaseHTTPRequestHandler):
    def do_GET(self) -> None:
        if self.path != "/health":
            self.send_error(404)
            return

        payload = json.dumps({"status": "ok"}).encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(payload)))
        self.end_headers()
        self.wfile.write(payload)

    def log_message(self, format: str, *args: object) -> None:
        print(f"API request from {self.client_address[0]}: {format % args}")


if __name__ == "__main__":
    server = ThreadingHTTPServer(("127.0.0.1", 9000), Handler)
    print("Demo API listening on http://127.0.0.1:9000")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nStopping demo API.")
    finally:
        server.server_close()
