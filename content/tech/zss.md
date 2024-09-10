# zss
zss is a terminal pager implemented with the least amount of features while
still remaining functional.

## Features
### Key Binds
It contains the most basic of vim keys along side key repeating. Standard
movement keys are supported. Character jump keys (f, t) may be supported in the
fueture.

### Searching
Searching is considered a key feature of a pager and 

## Shortcommings
The implemention is very naive at this point. It attempts to mimimize lines of
code which means that it often will

### Color
Right now, the pager can handle color input but will cut the lines short as
doesnt distinguish between characters that are rendered and those that are not.
In a similar way it also struggles with unicode characters or anything where
its size in bytes in memory is not the same as its 

### Terminal Codes
Right now, terminal codes are handled naivly with simple implemention.

## Summary
Right now the poject is functional, however, it has many correctness issues
that can only be fixed by adding a large amount of complexity to the code. Much
of this complexity is inherent to terminal applications which need to handle
two different types of input (user and system) from the same source (/dev/tty).

This leaves every consumer of this api left with this choice of correctness vs
simplicty. This leads to the near ubiquity of curses libraries that aim to fix
provide a centralized implemention of this parsing.

There are two possible solutions
It is very likley t
