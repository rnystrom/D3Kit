D3Kit
=====

#D3Kit 

##Installation

To get started, add D3Kit as a submodule to your project. Make sure to add the submodule from the root of your project.

<code>git submodule add git@github.com:rnystrom/D3Kit.git</code>

Then drag <code>D3Kit.xcodeproj</code> into your project. Location does not matter.

![D3Kit as subproject ](https://github.com/rnystrom/D3Kit/blob/master/images/project.png?raw=true)

Open the **Build Phases** of *your* project. Add D3Kit as a **Target Dependency**.

![Target Dependency ](https://github.com/rnystrom/D3Kit/blob/master/images/dependencies.png?raw=true)

Then add <code>libD3Kit.a</code> to **Link Binary With Libraries**.

![Link Binary with Libraries ](https://github.com/rnystrom/D3Kit/blob/master/images/libraries.png?raw=true)

In *your* project, open the **Build Settings** tab. Search for "User Header Search Paths". Set this value to <code>"${PROJECT_DIR}/D3Kit"</code> (including quotes ). Also set "Always Search User Paths" to YES.

![Search Paths ](https://github.com/rnystrom/D3Kit/blob/master/images/search-paths.png?raw=true)

Find the “Other Linker Flags” option, and add the value -ObjC (no quotes ).

![Flags](https://github.com/rnystrom/D3Kit/blob/master/images/flags.png?raw=true)
    
In your Prefix.pch file add <code>#import &lt;D3Kit/D3Kit.h&gt;</code> and you're done!
