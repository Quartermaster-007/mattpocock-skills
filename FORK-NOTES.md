# Fork notes

This is a personal fork of [mattpocock/skills](https://github.com/mattpocock/skills),
maintained so I can customize the skills and control when upstream changes land.

- **Fork:** `Quartermaster-007/mattpocock-skills`
- **Local clone:** `~/Projects/agents/mattpocock-skills`
- **Remotes:** `origin` → my fork · `upstream` → `mattpocock/skills`

## How Claude Code loads this

The skills load through **symlinks**: `scripts/link-skills.sh` links every skill outside `deprecated/` and `misc/` into `~/.claude/skills` and `~/.agents/skills`, each entry pointing into this clone. Claude Code reads the clone directly, so **an edit here is live in the next skill invocation**, with no push or plugin update. Whatever branch this clone has checked out is what every session runs: switch back to `main` before leaving an experiment unmerged. Re-run the script after adding, removing, or renaming a skill.

`~/.claude/settings.json` still registers this fork as the `mattpocock` marketplace, but the plugin is **not enabled** (`"enabledPlugins": {}`), so the plugin cache plays no part:

```json
"extraKnownMarketplaces": {
  "mattpocock": { "source": { "source": "github", "repo": "Quartermaster-007/mattpocock-skills" } }
}
```

To load the plugin instead (for example on a machine without this clone), enable `"mattpocock-skills@mattpocock": true`. Edits then take effect only after a push and `/plugin marketplace update mattpocock`, so remove the symlinks then to keep one source per skill.

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
