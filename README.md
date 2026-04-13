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

## Grabbing your tokens

You need three things from your browser. All of them live in your browser cookies and network tab.

### 1. Session token

1. Open your Atlassian site (e.g. `yoursite.atlassian.net`)
2. Open DevTools (`Cmd+Option+I` / `F12`)
3. Go to **Application** > **Cookies** > your site URL
4. Copy the value of `tenant.session.token`
5. Paste it as `ROVO_SESSION_TOKEN` in `.env`

> This token expires every ~30 days. When rovo stops working, just grab a fresh one.

### 2. XSRF token

Same cookies table - copy `atl.xsrf.token` into `ROVO_XSRF_TOKEN`.

### 3. Conversation ID

1. Open Rovo chat in Confluence (the AI chat widget)
2. Send any message
3. In DevTools **Network** tab, look for a request to `.../rovo/v1/chat/conversation/.../message/stream/sse`
4. The UUID in that URL path is your conversation ID

Fill these into your `.env` and you're good to go.

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

One curl to the Rovo SSE streaming endpoint, piped through a tiny Python script to extract the answer chunks. That's it. No dependencies beyond `curl` and `python3`.

## Limitations

- Uses browser session cookies, not an API key (Rovo doesn't have a public API yet)
- Tokens expire (~30 days) - you'll need to refresh them from your browser
- One conversation thread per `.env` config

## License

MIT
