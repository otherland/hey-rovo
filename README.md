# hey-rovo

Talk to [Atlassian Rovo](https://www.atlassian.com/software/rovo) from your terminal. No API keys needed - just your browser session.

```
$ rovo "what tickets did I update this week?"

Here are your recently updated tickets:
1. PROJ-42 - Fix the thing that broke the other thing
2. PROJ-99 - Add dark mode (finally)
...
```

## Setup

```bash
git clone https://github.com/otherland/hey-rovo.git
cd hey-rovo
cp .env.example .env
chmod +x rovo
```

Edit `.env` with your site URL and session token (see below).

## Grabbing your session token

You only need one thing from your browser:

1. Open your Atlassian site (e.g. `yoursite.atlassian.net`)
2. Open DevTools (`Cmd+Option+I` / `F12`)
3. Go to **Application** > **Cookies** > your site URL
4. Copy the value of `tenant.session.token`
5. Paste it as `ROVO_SESSION_TOKEN` in `.env`

That's it. The token expires every ~30 days - when rovo stops working, just grab a fresh one.

## Usage

```bash
# Ask anything
./rovo "how do we deploy to production?"

# Multi-word queries just work
./rovo what tickets are blocked right now

# Add to your PATH for convenience
ln -s "$(pwd)/rovo" /usr/local/bin/rovo
```

## How it works

One curl to the Rovo SSE streaming endpoint, piped through `grep` and `sed` to extract the answer. No dependencies beyond `curl` and standard unix tools.

Each question starts a fresh conversation by default. Set `ROVO_CONVERSATION_ID` in `.env` to reuse the same thread.

## Limitations

- Uses browser session cookies, not an API key (Rovo doesn't have a public API yet)
- Token expires (~30 days) - refresh from your browser when it stops working
- Requires `curl` and `uuidgen` (both pre-installed on macOS and most Linux)

## License

MIT
