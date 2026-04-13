<p align="center">
  <img src="hero.png" alt="hey-rovo" width="700">
</p>

<h1 align="center">hey-rovo</h1>

<p align="center">
  <em>Talk to Atlassian Rovo from your terminal.</em><br>
  One bash script. No API key. No dependencies.
</p>

<p align="center">
  <a href="#setup">Setup</a> &middot;
  <a href="#usage">Usage</a> &middot;
  <a href="#how-it-works">How it works</a> &middot;
  <a href="LICENSE">MIT License</a>
</p>

---

```
$ rovo "what tickets did I update this week?"

Here are your recently updated tickets:
1. PROJ-42 - Fix the thing that broke the other thing
2. PROJ-99 - Add dark mode (finally)
3. PROJ-7  - Update docs nobody reads
```

Rovo doesn't have a public API. This script doesn't care. It uses your browser session cookie to hit the same streaming endpoint that the Rovo chat widget uses. One cookie, one curl, done.

## Setup

```bash
git clone https://github.com/otherland/hey-rovo.git
cd hey-rovo
cp .env.example .env
chmod +x rovo
```

Then grab your session token (takes 30 seconds):

1. Open your Atlassian site in Chrome
2. DevTools (`Cmd+Option+I`) > **Application** > **Cookies**
3. Copy `tenant.session.token`
4. Paste into `.env`

```env
ROVO_BASE_URL="https://yoursite.atlassian.net"
ROVO_SESSION_TOKEN="eyJraWQ..."
```

That's the whole setup. Token lasts ~30 days — when it stops working, grab a fresh one.

## Usage

```bash
./rovo "how do we deploy to production?"
./rovo what tickets are blocked right now
./rovo "summarise the last sprint retro"
```

Optionally add to your PATH:

```bash
ln -s "$(pwd)/rovo" /usr/local/bin/rovo
```

## How it works

```
you → curl → Rovo SSE endpoint → grep + sed → terminal
```

Each question starts a fresh conversation. Set `ROVO_CONVERSATION_ID` in `.env` to keep a thread going.

The entire script is ~40 lines of bash. No Python. No Node. No dependencies beyond `curl` and `uuidgen` (pre-installed on macOS and most Linux).

## License

MIT
