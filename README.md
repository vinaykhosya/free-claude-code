<div align="center">

# ⚡ Vinay's Free Claude Code Proxy

### A Claude-compatible proxy for VS Code + Claude Code CLI with flexible model routing

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Python 3.14](https://img.shields.io/badge/python-3.14-3776ab.svg?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/downloads/)
[![uv](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/uv/main/assets/badge/v0.json&style=for-the-badge)](https://github.com/astral-sh/uv)

</div>

A lightweight proxy that routes Claude Code requests to **NVIDIA NIM**, **OpenRouter**, **LM Studio**, or **llama.cpp** using Anthropic-compatible endpoints.

---

## 👤 Project ownership

This project is customized and maintained by **Vinay** for practical, low-cost Claude-style coding workflows.

> This repository is an independent project and is not affiliated with Anthropic, NVIDIA, or OpenRouter.

---

## ✨ Highlights

- Anthropic-compatible API (`/v1/messages`, `/v1/messages/count_tokens`)
- Per-request model mapping (`MODEL_OPUS`, `MODEL_SONNET`, `MODEL_HAIKU`, fallback `MODEL`)
- Multi-provider support (NVIDIA NIM, OpenRouter, LM Studio, llama.cpp)
- Streaming response translation to Claude-compatible SSE events
- Request optimizations to reduce token usage on trivial internal calls
- Optional Discord/Telegram orchestration with queue/tree-based session handling
- Optional voice-note transcription pipeline

---

## 🚀 Quick Start (Windows)

You asked for fully simplified setup: done.

### 1) Install everything

Run:

- `install.bat`

What it does:

- installs `uv` if missing
- updates `uv`
- installs Python 3.14 through `uv`
- installs dependencies (`uv sync --all-extras`)
- creates `.env` from `.env.example` (if `.env` is missing)

### 2) Add your keys/models

Open `.env` and set at minimum:

- `NVIDIA_NIM_API_KEY` (or other provider key)
- `MODEL_OPUS`, `MODEL_SONNET`, `MODEL_HAIKU`, `MODEL`

### 3) Start server

Run:

- `run.bat`

(`run.bat` calls `start.bat` internally.)

---

## 🔌 Connect to Claude Code in VS Code

Add this to VS Code `settings.json`:

```json
"claudeCode.environmentVariables": [
  { "name": "ANTHROPIC_BASE_URL", "value": "http://localhost:8082" },
  { "name": "ANTHROPIC_AUTH_TOKEN", "value": "your-auth-token-here" }
]
```

Then reload extensions / restart VS Code.

---

## 🧠 Model routing behavior

This proxy does **not** inherently run Anthropic Claude models directly.

Instead, Claude model labels are mapped to your configured providers/models:

- Claude Opus requests → `MODEL_OPUS`
- Claude Sonnet requests → `MODEL_SONNET`
- Claude Haiku requests → `MODEL_HAIKU`
- Unknown model names → `MODEL` (fallback)

Example values:

```dotenv
MODEL_OPUS="nvidia_nim/qwen/qwen3.5-397b-a17b"
MODEL_SONNET="nvidia_nim/moonshotai/kimi-k2.5"
MODEL_HAIKU="nvidia_nim/stepfun-ai/step-3.5-flash"
MODEL="nvidia_nim/qwen/qwen3.5-397b-a17b"
```

---

## ⚙️ Configuration

Environment loading priority:

1. `~/.config/free-claude-code/.env`
2. project `./.env`
3. `FCC_ENV_FILE` (if set)

Common config keys:

- `NVIDIA_NIM_API_KEY`
- `OPENROUTER_API_KEY`
- `LM_STUDIO_BASE_URL`
- `LLAMACPP_BASE_URL`
- `MODEL`, `MODEL_OPUS`, `MODEL_SONNET`, `MODEL_HAIKU`
- `ANTHROPIC_AUTH_TOKEN`
- `PROVIDER_RATE_LIMIT`, `PROVIDER_RATE_WINDOW`, `PROVIDER_MAX_CONCURRENCY`
- `HTTP_READ_TIMEOUT`, `HTTP_WRITE_TIMEOUT`, `HTTP_CONNECT_TIMEOUT`
- messaging and voice keys (Discord/Telegram/Whisper)

See `.env.example` for full reference.

---

## 🗂 Project structure

```text
free-claude-code/
├── api/           # FastAPI routes, auth dependencies, request models, optimizations
├── providers/     # Provider abstraction + NVIDIA/OpenRouter/LM Studio/llama.cpp clients
├── messaging/     # Discord/Telegram adapters, queue trees, event parsing, transcripts
├── cli/           # Claude CLI session manager + process lifecycle handling
├── config/        # Settings, env handling, logging
├── tests/         # API, provider, CLI, config, messaging coverage
├── install.bat    # One-click dependency install for Windows
├── start.bat      # Start server
├── run.bat        # Convenience launcher (calls start.bat)
└── server.py      # Runtime entrypoint
```

---

## 🧪 Development checks

```bash
uv run ruff format
uv run ruff check
uv run ty check
uv run pytest
```

---

## 🔐 Security checklist before publishing

- Keep real keys only in `.env`
- Never commit secrets to `.env.example`
- Rotate any leaked keys immediately
- If exposing server publicly, set `ANTHROPIC_AUTH_TOKEN`

---

## 🤝 Contributing

Contributions and suggestions are welcome.

Good areas:

- provider quality improvements
- reliability and retry tuning
- UX/documentation upgrades
- additional platform integrations

---

## 📄 License

MIT — see [`LICENSE`](LICENSE).
