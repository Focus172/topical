---
title: Software Building
---
# Building

Everyone has unique ideas on how to build software

first write a scala program,
next compile it to jvm binary

next decompile that to java using TOOL
next transpile that to kotlin using jetbrains tools

next compile the kotlin to webassembly,
next create a wrapper program that statically compile a webassembly and embeds the program to run

use ghidra to decompile that program into c
use zig to transpile that into zig

compile the zig optimizing for size to place all code in one stack frame
also make sure that you rename the _start function to _startZ and compile as a lib

next make a custom build of the linux kernal that instread of `exec` the init just calls you library you just made
statically compile qemu for a macos and embed you init fs into the program to be used

the next step is a little hard:
- your executable is likly larger than 4gb which is the max size for an exe in windows
- so you need to embed you executable into a container format (we will use a pdf as it is industry standard)
- next you need to make an entry point in the file that maps your binary (also in the file) to virtual memory to execute it

writing this program could be hard but we have the worlds most safe language to help us: rust, btw.


security

docker
nix 

emulating a different system beacuse this one is comprimised


## Deploying
using ssh into a server

dont use ssh beacuse having multipule people logged into the same user (thats bad bc linux is bad at managing shared resources)
instead setup an irc chat where people can type commands (also create different user for each memeber bc linux is good with shared resources)


