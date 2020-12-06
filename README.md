# BouncingBalls

## Why is this a thing?
This is a very basic program designed so that I could gather some experience using raylib-d.
It is not meant to be an example of good D code, nor a good example of good raylib technique.

I figured it might be a good idea to have more resources for raylib-d available, rather than less and so
posted it up here for others to see.

Therefore **expect** messy code and less than optimal ways of achieving things.

Lets also not talk about my circle collision handling...

## Resources
If you're new to raylib-d then this repository may have some useful examples for you; however,
I recommend you check out the following resources which allowed me, and helped me, to create this program.

### Tools Used

https://www.raylib.com/
https://dlang.org/
https://github.com/dlang/dub
https://www.vim.org/

Massive thanks to those responsible for the Dlang bindings for raylib!
https://github.com/onroundit/raylib-d

### Documentation
https://www.raylib.com/cheatsheet/cheatsheet.html

## If for some crazy reason you want to run this

These instructions should work for Debian and Arch flavours of Linux.

1. Download the source
1. Install DMD: (i.e., 'sudo apt install dmd')
1. Install raylib: (go to the github repo for raylib (https://github.com/raysan5/raylib/wiki/Working-on-GNU-Linux)
1. Go through their instructions. (I installed the dynamic shared libs)
1. Finally go to the BouncingBalls folder and use the following command: (dub run) 

