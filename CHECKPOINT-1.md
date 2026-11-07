# CSE 642 Checkpoint 1: your landing page, running on your computer

You will start a website on your own computer, then change it by describing the change to an AI coding tool. You do not need to know how to code.

**You need:** Docker Desktop (open and running), Git, and VS Code. Your course environment check should end with `READY for Checkpoint 1`.

## Steps

1. **Get the code.** Open a terminal and run:

   ```bash
   git clone --branch CP1-start https://github.com/pingwu/agentic-landing-template.git cse642-landing
   cd cse642-landing
   git switch -c my-site
   ```

   `CP1-start` is a fixed starting point: everyone who uses it gets the same code. Git will say you are in a "detached HEAD" state after the clone. That is expected. The `git switch -c my-site` line makes your own branch named `my-site` so your edits are saved there.

2. **Start the page.**

   ```bash
   docker compose up
   ```

   The first start downloads images and takes a few minutes. It is ready when the output shows the page compiled, or when `docker compose ps` (in a second terminal) says `healthy`.

3. **Look at it.** Open <http://localhost:3000> in your browser. `localhost` means "this computer"; `3000` is the port the page listens on.

4. **Change it with plain language.** Open the folder in VS Code and ask your AI coding tool (Copilot, Claude Code, Codex, Gemini) for changes. Use the right words for the thing you want. Examples:

   - "In `app/page.tsx`, change the logo text and the hero heading to my name and my job title."
   - "Add a contact section with my email and my LinkedIn link."
   - "Change the accent color from blue to green across the page."

   Save the file and the browser updates in a few seconds. If you describe the change clearly and name the file or section, you get better results.

5. **Save your work.**

   ```bash
   git add -A
   git commit -m "My landing page"
   ```

6. **Stop it** when you are done. In the terminal that is running `docker compose up`, press `Ctrl+C`, then run:

   ```bash
   docker compose down
   ```

## What to hand in

A screenshot of your changed page at `localhost:3000`, together with your Session 2 worksheet. Do not include passwords, keys or private details in the screenshot.

## If something goes wrong

| What you see | What it means | What to do |
| --- | --- | --- |
| `Cannot connect to the Docker daemon`, or `docker` hangs | Docker Desktop is not running (check code `DOCKER_DAEMON_DOWN`) | Open Docker Desktop and wait until it says it is running, then try again |
| `port is already allocated` or `address already in use` | Something else is using port 3000 | Pick another port. macOS: `PORT=3100 docker compose up`. Windows PowerShell: `$env:PORT=3100; docker compose up`. Then open `localhost:3100` |
| Page does not open after a long wait | The first start is still downloading | Wait until `docker compose ps` shows `healthy`. On slow Wi-Fi this can take several minutes |
| Edits do not appear (Windows) | The file change was not noticed yet | Wait 10 seconds and reload. Keep the project in your user folder, not on a network drive |
| `EACCES: permission denied` in the output | Old volume left from an earlier try | Run `docker compose down -v`, then `docker compose up` again |
| Docker says `not enough memory` or your computer slows to a crawl | Your computer is below the 16 GB RAM minimum | Use Codespaces (below) |

Stuck for more than 20 minutes? Ask in the course Slack. Share only the tool name and the error text, never keys or passwords.

## No Docker? Use GitHub Codespaces

If your computer is below the minimum (16 GB RAM, 30 GB free disk) or Docker will not start, run the same project in the cloud: on the repository page choose **Code → Codespaces → Create codespace on `CP1-start`**. The page opens in a forwarded port. The free monthly allowance is limited, so **stop the codespace** when you finish (**Codespaces → ⋯ → Stop**).

## Later, optional

Deploying the page to the public internet (for example with Vercel or Google Cloud) is optional and not part of Checkpoint 1. The `docs/` folder has older cloud deployment guides if you want to explore.
