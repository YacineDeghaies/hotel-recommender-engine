FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    HF_HOME=/cache/huggingface

WORKDIR /app

COPY pyproject.toml README.md ./
COPY src/ ./src/
RUN pip install --no-cache-dir .

COPY docker/wait_for_qdrant.py ./docker/wait_for_qdrant.py

CMD ["uvicorn", "hotel_recommender_engine.api.app:app", "--host", "0.0.0.0", "--port", "8000"]
