D3Kit
=====

#Installation
<code>git submodule add git@github.com:rnystrom/D3Kit.git</code>

* Drag <code>D3Kit.xcodeproj</code> into your project. Location does not matter.
* In your build phases, add D3Kit as a Target Dependency.
* In your build phases, add libD3Kit.a to Link Binary With Libraries
* In your Prefix.pch file add <code>#import < D3Kit/D3Kit.h ></code>
* In YOUR project configuration, on the “Build Settings” tab
    * locate the “User Header Search Paths” setting, and set the Release value to "${PROJECT_DIR}/D3Kit" (including quotes! ) and check the “Recursive” check box.
    * The Debug value should already be set, but if it’s not, change that as well.
    * Also locate the “Always Search User Paths” value and set it to YES.
    * Finally, find the “Other Linker Flags” option, and add the value -ObjC (no quotes ).
