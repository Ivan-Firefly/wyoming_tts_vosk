FROM python:3.11-slim-bookworm

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates libgomp1 libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/wyoming_tts_vosk

COPY requirements.txt ./requirements.txt
RUN python -m pip install --upgrade pip \
    && python -m pip install -r requirements.txt

COPY . .

EXPOSE 10205

# Compose supplies the model path and other runtime options.
CMD ["python", "-m", "wyoming_tts_vosk", "--help"]
