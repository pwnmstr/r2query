#!/usr/bin/env python3
import sys
import re

cheatsheet = """=== Navigation ===
s [addr]     : Seek to address
s+ [expr]    : Seek relative positive
s- [expr]    : Seek relative negative
so [N]       : Seek N opcodes
sf           : Seek to next function

=== Analysis ===
aa           : Analyze all (basic)
aaa          : Analyze all (autoname, references, etc.)
afl          : List functions
pdf          : Print disassembled function
ag           : Generate graphs
axt [addr]   : Find cross references to (calls to) address
axf [addr]   : Find cross references from (calls from) address

=== Information ===
iI           : Binary info
is           : Symbols
iz           : Strings
ie           : Entrypoints
iS           : Sections

=== Printing / Disassembly ===
pd [N]       : Print N instructions (disassemble)
px [N]       : Print N bytes in hexdump
p8 [N]       : Print N bytes in hex pairs
pda          : Disassemble all

=== Debugging ===
dc           : Continue execution
db [addr]    : Add breakpoint
ds           : Step one instruction
dr           : Read CPU registers
dr=          : Read CPU registers (columns)

=== Patching ===
wx [hex]     : Write hex bytes at current seek
wa [asm]     : Write assembly at current seek
wc           : Write cache (commit patches)

=== Search ===
/ [str]      : Search for string
/x [hex]     : Search for hex bytes
/a [asm]     : Search for assembly instructions
"""

def colorize(text, query):
    if not query:
        return text
    # Very basic colorization using ANSI escape codes
    return re.sub(f"({re.escape(query)})", r"\033[1;31m\1\033[0m", text, flags=re.IGNORECASE)

def print_help(query=""):
    lines = cheatsheet.split('\n')
    if not query:
        print(cheatsheet)
        return

    found = False
    for line in lines:
        if query.lower() in line.lower():
            print(colorize(line, query))
            found = True

    if not found:
        print(f"No matches found for '{query}'.")
        print("Try exploring other keywords or type $H to view the full cheatsheet.")

if __name__ == "__main__":
    query = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else ""
    print_help(query)
