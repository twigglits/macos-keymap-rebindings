# Windows-style keyboard shortcuts on macOS

A system-wide [Karabiner-Elements](https://karabiner-elements.pqrs.org/) config that
makes macOS behave like Windows for the common editing/navigation shortcuts: pressing
**`Ctrl+<key>`** does what **`Cmd+<key>`** normally does on a Mac.

This is for people coming from Windows whose muscle memory expects `Ctrl+C`, `Ctrl+V`,
`Ctrl+S`, etc. Native `Cmd+` shortcuts are left fully intact — this only *adds* the
`Ctrl`-based equivalents.

## What's in here

- **`karabiner.json`** — the Karabiner-Elements configuration (the actual keymaps).
- **`install.sh`** — a helper that copies `karabiner.json` into the right place on your
  Mac, backing up any existing config first.

The remapping lives in a single Complex Modification rule, *"Windows-style shortcuts"*,
inside the **Default profile**.

## Getting Started

### Prerequisites

- **macOS** — Karabiner-Elements is a macOS-only app.
- **[Karabiner-Elements](https://karabiner-elements.pqrs.org/)** — the engine that runs
  this config. Install it with [Homebrew](https://brew.sh/):

  ```sh
  brew install --cask karabiner-elements
  ```

  …or grab the installer from <https://karabiner-elements.pqrs.org/>.

  On first launch, macOS prompts you to approve Karabiner-Elements under **System
  Settings → Privacy & Security → Input Monitoring** and to enable its background
  driver/system extension. Karabiner walks you through this — approve it, or the
  remappings won't take effect.

### Install the keymap

1. Get the files — clone the repo (or download the ZIP and unzip it):

   ```sh
   git clone https://github.com/twigglits/macos-keymap-rebindings.git
   cd macos-keymap-rebindings
   ```

2. Run the installer:

   ```sh
   ./install.sh
   ```

   It checks that you're on macOS with Karabiner-Elements installed, validates the
   config, **backs up** any existing `~/.config/karabiner/karabiner.json` (with a
   timestamp), then copies this keymap into place.

   > **Tip:** if you see `permission denied`, run `bash install.sh` instead — or make it
   > executable first with `chmod +x install.sh`.

3. That's it. Karabiner-Elements watches the config file and reloads automatically — no
   restart needed. If the shortcuts don't kick in, open Karabiner-Elements and confirm
   the **"Default profile"** is selected.

> **Note:** installing **overwrites** `~/.config/karabiner/karabiner.json`. That's
> expected — the installer always saves a timestamped backup first (e.g.
> `karabiner.json.backup-20260603-114900`), so you can roll back if you change your mind.

### Manual install (without the script)

Prefer to do it by hand? Copy the file into place yourself:

```sh
# Back up your current config first, if you have one:
[ -f ~/.config/karabiner/karabiner.json ] && \
  cp ~/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json.backup

# Install:
mkdir -p ~/.config/karabiner
cp karabiner.json ~/.config/karabiner/karabiner.json
```

## Mappings

| You press | It does | Action |
|-----------|---------|--------|
| `Ctrl+C` | `Cmd+C` | Copy |
| `Ctrl+V` | `Cmd+V` | Paste |
| `Ctrl+X` | `Cmd+X` | Cut |
| `Ctrl+Z` | `Cmd+Z` | Undo |
| `Ctrl+Y` | `Cmd+Shift+Z` | Redo |
| `Ctrl+A` | `Cmd+A` | Select all |
| `Ctrl+S` | `Cmd+S` | Save |
| `Ctrl+Shift+S` | `Cmd+Shift+S` | Save as |
| `Ctrl+F` | `Cmd+F` | Find |
| `Ctrl+N` | `Cmd+N` | New |
| `Ctrl+T` | `Cmd+T` | New tab |
| `Ctrl+Shift+T` | `Cmd+Shift+T` | Reopen closed tab |
| `Ctrl+W` | `Cmd+W` | Close tab/window |
| `Ctrl+R` | `Cmd+R` | Reload |
| `Ctrl+Shift+R` | `Cmd+Shift+R` | Hard reload (bypass cache) |

`Caps Lock` is allowed as an optional modifier on every mapping, so holding it doesn't
break the shortcut.

### Lock screen

| You press | It does | Action |
|-----------|---------|--------|
| `Cmd+L` | `Ctrl+Cmd+Q` | Lock the screen |

Global (works everywhere). The Mac's normal "focus address bar" use of `Cmd+L` in
browsers moves to `Ctrl+L` — see below.

### Browser shortcuts (Chrome / Edge / Safari / Firefox / Arc / Brave)

| You press | It does | Action |
|-----------|---------|--------|
| `Ctrl+L` | `Cmd+L` | Focus & select the entire page URL |
| `Ctrl+D` | `Cmd+D` | Bookmark the current page |
| `Ctrl+1` … `Ctrl+8` | `Cmd+1` … `Cmd+8` | Jump to tab 1–8 |
| `Ctrl+9` | `Cmd+9` | Jump to the last tab |

Windows-style: `Ctrl+L` highlights the address bar, `Ctrl+D` bookmarks the page, and
`Ctrl+<number>` jumps straight to a tab. These mappings are **scoped to browsers** (they
do nothing in other apps). `Ctrl+L` is a separate physical key from the global `Cmd+L`
lock above, so the two never collide — and because Karabiner doesn't re-feed a rule's
output back through itself, `Ctrl+L → Cmd+L` reaches the browser as "focus address bar"
rather than re-triggering the lock.

### Code editor (VS Code & forks only)

| You press | It does | Action |
|-----------|---------|--------|
| `Ctrl+Shift+P` | `Cmd+Shift+P` | Open the command palette |

Windows-style: `Ctrl+Shift+P` opens the command palette ("Show All Commands"). This is
**scoped to VS Code and its forks** and does nothing in other apps. Covered editors:
VS Code, VS Code Insiders, VSCodium, Code-OSS, Cursor, and Windsurf.

> **Using a different editor?** Get its bundle ID with
> `osascript -e 'id of app "Your Editor"'`, then add it (regex-escaped, e.g.
> `^com\\.example\\.editor$`) to the `bundle_identifiers` list of the *IDE* rule in
> `karabiner.json`.

### Finder (Finder only)

| You press | It does | Action |
|-----------|---------|--------|
| `Cmd+Q` | `Cmd+Option+W` | Close all open Finder windows |

Finder can't actually be quit, so `Cmd+Q` is repurposed (in Finder only) to fire its
native *Close All Windows* command. Everywhere else, `Cmd+Q` quits the app as normal.

### Application switcher (Alt+Tab)

| You press | It does | Action |
|-----------|---------|--------|
| `Alt+Tab` | `Cmd+Tab` | Cycle forward through running apps |
| `Alt+Shift+Tab` | `Cmd+Shift+Tab` | Cycle backward |
| `` Alt+` `` | `` Cmd+` `` | Cycle through windows of the focused app |
| `` Alt+Shift+` `` | `` Cmd+Shift+` `` | Cycle those windows backward |

Works just like Windows/Linux: **hold `Alt` and tap `Tab`** to step through the macOS
app switcher gallery, then release `Alt` to select. Once you're in an app, **hold `Alt`
and tap `` ` ``** (the backtick/tilde key) to cycle between that app's own windows. These
mappings are their own rules and are **not** excluded in terminals — you can switch from
anywhere, including a focused terminal. (`Alt` is the Option key.)

#### Restoring minimized windows

Plain `Cmd+Tab` — and therefore this `Alt+Tab` — has a long-standing macOS quirk:
switching to an app whose windows are **all minimized** brings the app to the front but
leaves its windows sitting in the Dock, so nothing actually appears on screen. To fix
that, the Alt+Tab rule fires a short AppleScript ~0.4 s *after the switch settles* that
un-minimizes every minimized window of the now-focused app, so the window you tabbed to
actually shows up.

The timing uses Karabiner's [`to_delayed_action`](https://karabiner-elements.pqrs.org/docs/json/complex-modifications-manipulator-definition/to-delayed-action/):
each `Tab` tap re-arms a 400 ms timer, and only once you stop tapping does the script run.
Tune it via `basic.to_delayed_action_delay_milliseconds` on the Alt+Tab rule.

This one behavior needs **Accessibility** permission — the rest of the keymap does **not**.
Karabiner runs the script through a helper, so the permission is granted to *that helper*,
not to `Karabiner-Elements.app`:

> **System Settings → Privacy & Security → Accessibility** → add
> `/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_console_user_server`
> and switch it **on**.

A freshly-granted permission isn't picked up by the **already-running** helper until it
restarts. Either restart Karabiner-Elements from its menu-bar icon, or kick just the helper:

```sh
launchctl kickstart -k "gui/$(id -u)/org.pqrs.service.agent.karabiner_console_user_server"
```

To confirm it works: minimize a window, `Alt+Tab` away, then `Alt+Tab` back — after ~0.4 s
the window should un-minimize on its own.

Until it's granted, the switch still works — the minimized windows just won't auto-restore.
One edge case: if you routinely *pause* inside the switcher gallery for longer than the
delay, the timer can fire early and restore the app you were leaving instead; the windows
that pop up are harmless, and a quick alt-tab brings you back.

## Terminals are excluded

Every `Ctrl`-based mapping carries a `frontmost_application_unless` condition so it is
**disabled in terminal apps**. This keeps shell control keys working as expected —
`Ctrl+C` sends SIGINT, `Ctrl+R` is reverse-search, `Ctrl+W` deletes a word, etc.
(The Alt+Tab app switcher is intentionally exempt — it works everywhere.)

Excluded apps: Terminal, iTerm2, Ghostty, Alacritty, kitty, WezTerm, Warp, Hyper.

## Editing / adding a mapping

Edit `~/.config/karabiner/karabiner.json` with a JSON-aware tool. To add a mapping,
deep-copy the `conditions` block from an existing manipulator so the terminal-exclusion
list stays identical.

Validate before relying on it:

```sh
"/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli" \
  --lint-complex-modifications ~/.config/karabiner/karabiner.json
```

**Gotcha:** don't run `karabiner_cli --select-profile` right after editing the file by
hand — it writes the *in-memory* config back to disk and will clobber your edit before
the watcher picks it up. Rely on the file watcher instead.
