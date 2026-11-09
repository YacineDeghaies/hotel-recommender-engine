"""Wait for Qdrant before starting ingestion or the API container."""

from __future__ import annotations

import time
from urllib.error import URLError
from urllib.request import urlopen

for attempt in range(60):
    try:
        with urlopen("http://qdrant:6333/", timeout=2) as response:
            if response.status == 200:
                break
    except (OSError, URLError):
        pass
    time.sleep(2)
else:
    raise SystemExit("Qdrant did not become ready within 120 seconds")
