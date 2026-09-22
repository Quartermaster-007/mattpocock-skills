# Fork notes

This is a personal fork of [mattpocock/skills](https://github.com/mattpocock/skills),
maintained so I can customize the skills and control when upstream changes land.

- **Fork:** `Quartermaster-007/mattpocock-skills`
- **Local clone:** `~/Projects/agents/mattpocock-skills`
- **Remotes:** `origin` → my fork · `upstream` → `mattpocock/skills`

## How Claude Code loads this

`~/.claude/settings.json` registers this fork as the `mattpocock` marketplace:

```json
"extraKnownMarketplaces": {
  "mattpocock": { "source": { "source": "github", "repo": "Quartermaster-007/mattpocock-skills" } }
},
"enabledPlugins": { "mattpocock-skills@mattpocock": true }
```

Claude Code clones this repo into its managed plugin cache. **Edits in this local
clone don't take effect until pushed to the fork**, then run `/plugin marketplace
update mattpocock` (or restart Claude Code).

### Live editing without pushing

To test local edits immediately, launch Claude Code with:

```bash
claude --plugin-dir ~/Projects/agents/mattpocock-skills
```

## Staying in sync with Matt

There is **no built-in notifier** for upstream releases. Two pieces:

1. **Get notified:** on GitHub, Watch → Custom → Releases on `mattpocock/skills`.
2. **See what changed / pull it in:**
   ```bash
   ./check-upstream.sh          # how far behind + new commits & changeset notes
   ./check-upstream.sh --sync   # merge upstream/main, then review and: git push
   ```

After syncing, bump the plugin so Claude Code sees a new version, then update:

```bash
npm run version                 # applies changesets + syncs plugin.json version
git push
# in Claude Code:
/plugin marketplace update mattpocock
```

## Making it truly "mine"

Customizations go on `main` (or a branch) and get committed like any change.
Keep them small and localized so upstream merges stay low-conflict. `FORK-NOTES.md`
and `check-upstream.sh` are fork-only files and won't conflict with upstream.
