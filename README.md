# Details

This repository contains my home folder bash initialization scripts. The 
whole idea of this repository is to easily share as many things as possible 
between environment variable. Feel free to re-use it for your own needs and
don't hesitate to contribute to the project by discussing ideas like 
improving the scripts, the organization of this repository or any other
improvements in the [issues](https://github.com/maoueh/personalhome/issues) 
section.

## Organization

There is nice challenges when it comes the time to manage your `personalhome`
to feel comfortable working with. The biggest concern arise when sharing
your scripts and everything from machine to machine. Having two development
devices (one at work and one at home) is probably the most common but I'm
sure some of you have three or more.

Parts of scripts and configuration files are machine specific while other
are not at different layers; i.e. that they can be shared across multiple
machine depending on some characteristics like distro, os, bash terminal,
etc.

This repository started as machine specific repository to share among
two machines. I now started experimenting for a better branching model
more usable to split general configuration file and script from ones that
change machine to machine.

Each subsection is dedicated to a particular branch. Following, some
convention and pattern for merge, I hope to be able to compose base
machine easily.

### Branch `common`

The starting branch containing at least the license file and this
readme. It could contain at term more files but I don't see how.

### Branch `bash`

Base branch for stuff that works with `bash` but not tied to a 
particular distro (at least trying really hard).

### Branch `msys2-bash`

Base branch for stuff that works with `bash` but and tied to a 
particular to an [msys2](http://sourceforge.net/projects/msys2/) distro
(Windows based) (at least trying really hard).

### Other branches

These are machine specific branches. 

My current system has the following specifications:

 * [MSYS2](http://sourceforge.net/projects/msys2/) installed in `C:\Gnu`
 * Development tools installed in `C:\Local`
 * Windows 7

## Discussion & Ideas

The whole idea of this repository is to easily share as many things
as possible between environment variable.

When looking at the goal and not the way to go it, maybe this repository
is useless and it exists a better system for this. Here some random ideas.

### Chef based

Maybe keeping a private chef repository each machine being a node and
leverage cookbook and roles to leverage this to create something better
than this. I did not evaluated yet the difference between the current
git approach and this idea.
