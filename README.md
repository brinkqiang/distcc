# distcc

Copyright (c) 2013-2018 brinkqiang (brink.qiang@gmail.com)

[distcc GitHub](https://github.com/brinkqiang/distcc)

## Build status
| [Linux][lin-link] | [MacOSX][osx-link] | [Windows][win-link] |
| :---------------: | :----------------: | :-----------------: |
| ![lin-badge]      | ![osx-badge]       | ![win-badge]        |

[lin-badge]: https://travis-ci.org/brinkqiang/distcc.svg?branch=master "Travis build status"
[lin-link]:  https://travis-ci.org/brinkqiang/distcc "Travis build status"
[osx-badge]: https://travis-ci.org/brinkqiang/distcc.svg?branch=master "Travis build status"
[osx-link]:  https://travis-ci.org/brinkqiang/distcc "Travis build status"
[win-badge]: https://ci.appveyor.com/api/projects/status/github/brinkqiang/distcc?branch=master&svg=true "AppVeyor build status"
[win-link]:  https://ci.appveyor.com/project/brinkqiang/distcc "AppVeyor build status"

## Intro
distcc

Distcc + Xcode Integration
==========================

Install
```
yum install binutils-devel -y

sh configure
make install
```
			
This is a fork of: 						

distcc -- a free distributed C/C++ compiler system

[http://code.google.com/p/distcc/](http://code.google.com/p/distcc/)

by Martin Pool <mbp@samba.org>

"pump" functionality added by Fergus Henderson, Nils Klarlund, Manos Renieris, and Craig Silverstein (Google Inc.)
			    
Containing the Xcode integration code v. 2805 from Apple used in Xcode 3 and earlier.
The Apple code is found here: [http://www.opensource.apple.com/source/distcc/](http://www.opensource.apple.com/source/distcc/)
Or as a tarball here: [http://opensource.apple.com/tarballs/distcc/](http://opensource.apple.com/tarballs/distcc/)

Additional changes have been made to integrate into Xcode 5+ as part of DistCode:
	 [https://github.com/marksatt/DistCode](https://github.com/marksatt/DistCode)

Original Readme
---------------

distcc -- a free distributed C/C++ compiler system

http://code.google.com/p/distcc/

by Martin Pool <mbp@samba.org>

"pump" functionality added by Fergus Henderson, Nils Klarlund, Manos Renieris, and Craig Silverstein (Google Inc.)
			    
distcc is a program to distribute compilation of C or C++ code across
several machines on a network. distcc should always generate the same
results as a local compile, is simple to install and use, and is often
two or more times faster than a local compile.

Unlike other distributed build systems, distcc does not require all
machines to share a filesystem, have synchronized clocks, or to have
the same libraries or header files installed. Machines can be running
different operating systems, as long as they have compatible binary
formats or cross-compilers.

By default, distcc sends the complete preprocessed source code across
the network for each job, so all it requires of the volunteer machines
is that they be running the distccd daemon, and that they have an
appropriate compiler installed.

The distcc "pump" functionality, added in distcc 3.0, improves on
distcc by distributing not only compilation but also preprocessing to
distcc servers. This requires that the server and client have the same
system headers (the client takes responsibility for transmitting
application-specific headers).  Given that, distcc in pump mode yields
the same results that distcc would in non-pump mode, but faster, since
the preprocessor no longer runs locally. For more details on the pump
functionality, see README.pump.

distcc is not itself a compiler, but rather a front-end to the GNU
C/C++ compiler (gcc), or another compiler of your choice. All the
regular gcc options and features work as normal.

distcc is designed to be used with GNU make's parallel-build feature
(-j). Shipping files across the network takes time, but few cycles on
the client machine. Any files that can be built remotely are
essentially "for free" in terms of client CPU.  This is even more true
in "pump" mode, where the client does not even have to take time to
preprocess the source files.  distcc has been successfully used in
environments with hundreds of distcc servers, supporting dozens of
simultaneous compiles.

distcc is now reasonably stable and can successfully compile the Linux
kernel, rsync, KDE, GNOME (via GARNOME), Samba and Ethereal.  distcc
is nearly linearly scalable for small numbers of machines: for a
typical case, three machines are 2.6 times faster than one.

distcc is distributed under the GNU General Public Licence v2.

## Contacts
[![Join the chat](https://badges.gitter.im/brinkqiang/distcc/Lobby.svg)](https://gitter.im/brinkqiang/distcc)

## Thanks
