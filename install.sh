#!/bin/sh
set -e

# Make local radare2 directories
mkdir -p ~/.local/share/radare2/
mkdir -p ~/.config/radare2/

# Copy the cheatsheet python script to a known local path
cp src/r2_cheatsheet.py ~/.local/share/radare2/r2_cheatsheet.py
chmod +x ~/.local/share/radare2/r2_cheatsheet.py

# Create a robust shell wrapper that handles radare2 alias argument passing safely
cat << 'INNER' > ~/.local/share/radare2/r2_cheatsheet.sh
#!/bin/sh
python3 ~/.local/share/radare2/r2_cheatsheet.py "$@"
INNER
chmod +x ~/.local/share/radare2/r2_cheatsheet.sh

# Temporary file approach to avoid bsd/gnu sed -i incompatibilities
cp ~/.config/radare2/radare2rc ~/.config/radare2/radare2rc.tmp 2>/dev/null || touch ~/.config/radare2/radare2rc.tmp
sed '/r2_cheatsheet/d' ~/.config/radare2/radare2rc.tmp > ~/.config/radare2/radare2rc

# Write the final alias mapping
echo "\$H=!~/.local/share/radare2/r2_cheatsheet.sh" | sed 's|~|'$HOME'|g' >> ~/.config/radare2/radare2rc

# Cleanup
rm -f ~/.config/radare2/radare2rc.tmp

echo "Cheatsheet helper installed successfully!"
echo "Open radare2 and try:"
echo "  \$H         -> See all help"
echo "  \$H \"seek\" -> Search for commands related to seeking"
