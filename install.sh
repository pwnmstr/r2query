#!/bin/sh
set -e

# Make local radare2 directories
mkdir -p ~/.local/share/radare2/
mkdir -p ~/.config/radare2/

# Copy the cheatsheet python script to a known local path
cp src/r2_cheatsheet.py ~/.local/share/radare2/r2_cheatsheet.py
chmod +x ~/.local/share/radare2/r2_cheatsheet.py

# Add the macro mapping to radare2rc
if grep -q "r2_cheatsheet" ~/.config/radare2/radare2rc 2>/dev/null; then
    sed -i '/r2_cheatsheet/d' ~/.config/radare2/radare2rc
    sed -i '/H=/d' ~/.config/radare2/radare2rc
fi

# The cleanest way to pass optional arguments into Python using radare2 is to
# execute python using an alias mapping `!python3` to radare2's `sys.argv`.
# However, Radare2 handles the string differently on different execution environments
# Let's map it into a generic shell call.
echo "\$H=!python3 ~/.local/share/radare2/r2_cheatsheet.py" | sed 's|~|'$HOME'|g' >> ~/.config/radare2/radare2rc

echo "Cheatsheet helper installed successfully!"
echo "Open radare2 and try:"
echo "  \$H         -> See all help"
echo "  \$H \"seek\" -> Search for commands related to seeking"
