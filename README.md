# Radare2 Cheatsheet Helper

A native side-by-side helper for Radare2. It adds an interactive and searchable cheatsheet directly into your `r2` environment.

## Installation
Run the install script to copy the python script and update your `~/.config/radare2/radare2rc`.

```bash
./install.sh
```

## Usage

Start `r2` as usual. Inside the console, you can now use `$H`.

To print the entire cheatsheet:
```
$H
```

To search for a specific keyword or basic task:
```
$H seek
$H patch
$H info
```

The script works fully offline and is directly integrated into your Radare2 session via native `r2` alias bindings and a Python search engine.
