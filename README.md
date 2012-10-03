![D3Kit](https://github.com/rnystrom/D3Kit/blob/master/images/logo.png?raw=true)
======

###Warning!

*D3Kit is still missing Fallen-Hero, Artisan, and Progression support. Coming soon!*

D3Kit is an easy to use layer to communicate with the [Diablo 3 API](http://blizzard.github.com/d3-api-docs/) maintained by Blizzard Entertainment. D3Kit handles all of the requests and gives you a simple block style callback system for successes and failures. After successful reqeusts are made, D3Kit parses the JSON response from Blizzard and builds NSObjects for you to use in your apps.

##Get Started
* [Installation](https://github.com/rnystrom/D3Kit#installation)
* [Overview](https://github.com/rnystrom/D3Kit#overview)
* [Career](https://github.com/rnystrom/D3Kit#career)
* [Hero](https://github.com/rnystrom/D3Kit#hero)
* [Images](https://github.com/rnystrom/D3Kit#images)
* [Documentation]()

##Installation

To get started, add D3Kit as a submodule to your project. Make sure to add the submodule from the root of your project.

<code>git submodule add git@github.com:rnystrom/D3Kit.git</code>

Then drag <code>D3Kit.xcodeproj</code> into your project.

![D3Kit as subproject ](https://github.com/rnystrom/D3Kit/blob/master/images/project.png?raw=true)

Open the **Build Phases** of *your* project. Add D3Kit as a **Target Dependency**.

![Target Dependency ](https://github.com/rnystrom/D3Kit/blob/master/images/dependencies.png?raw=true)

Then add <code>libD3Kit.a</code> to **Link Binary With Libraries**.

![Link Binary with Libraries ](https://github.com/rnystrom/D3Kit/blob/master/images/libraries.png?raw=true)

In *your* project, open the **Build Settings** tab. Search for "User Header Search Paths". Set this value to <code>"${PROJECT_DIR}/D3Kit"</code> (including quotes). Also set "Always Search User Paths" to YES.

![Search Paths ](https://github.com/rnystrom/D3Kit/blob/master/images/search-paths.png?raw=true)

Find the “Other Linker Flags” option, and add the value <code>-ObjC</code> (no quotes).

![Flags](https://github.com/rnystrom/D3Kit/blob/master/images/flags.png?raw=true)

In your Prefix.pch file add <code>#import &lt;D3Kit/D3Kit.h&gt;</code> and you're done!

##Overview

The classes that are populated from Blizzard's Diablo 3 API are:

* D3Artisan
* D3Career
* D3Follower
* D3Hero
* D3Item
* D3Rune
* D3Skill

Classes have relationships based on the Blizzard Diablo 3 API. Currently the relations are:

* D3Career <code>has many</code> D3Hero
* D3Career <code>has many</code> D3Artisan
* D3Hero <code>has many</code> D3Item
* D3Hero <code>has many</code> D3Skill
* D3Hero <code>has many</code> D3Follower
* D3Item <code>has one</code> D3Rune

The class <code>D3HTTPClient</code> helps retrieve information from Blizzard's Diablo 3 API is a subclass of AFNetworking's [AFHTTPClient](http://afnetworking.org/Documentation/Classes/AFHTTPClient.html). All functionality of <code>D3HTTPClient</code> is available. However there are helper methods included with each class to retrieve:

* Extra information (ie. D3Career call does not fully populate a D3Hero object by nature of the API)
* Images

##Career

To load a career and associated objects pass in an account NSString. This string should be in the format <code>battletag#1234</code> or else <code>failure()</code> will be called. The built-in validation requires a "#" to seperate the account name and number.

``` objective-c
[D3Career getCareerForBattletag:account success:^(D3Career *career) {
    // ...
} failure:^(NSError *error) {
    // ...
}];
```

##Hero

When <code>getCareerForBattletag:success:</code> is called each hero for the career is insantiated but not fully loaded because of the way the Blizzard Diablo 3 API is implemented (which is a good thing, as it keeps the response size small). To finish loading a D3Hero object, call:

``` objective-c
[hero finishLoadingWithSuccess:^(D3Hero *hero) {
    // ...
} failure:^(NSError *error) {
    // ...
}];
```

##Images

Currently all image requests are instance methods that return a [AFImageRequestOperation](http://afnetworking.org/Documentation/Classes/AFImageRequestOperation.html) in the assumption that images will be collected in batches. Ie:

``` objective-c
[hero.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    D3Item *item = (D3Item*)obj;
    AFImageRequestOperation *operation = [correspondingItem requestForItemIconWithImageProcessingBlock:NULL success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        // ...
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        // ...
    }];
    [mutOperations addObject:operation ];
}];
[[D3HTTPClient sharedClient ] enqueueBatchOfHTTPRequestOperations:mutOperations progressBlock:^(NSUInteger completedOperations, NSUInteger totalOperations){
    // ...
}completionBlock:^(NSArray *operations) {
    // ...
}];
```

However it should be trivial to add the [AFImageRequestOperation](http://afnetworking.org/Documentation/Classes/AFImageRequestOperation.html) to the queue of <code>D3HTTPClient</code>.

##Contact

[Ryan Nystrom](mailTo:rnystrom@whoisryannystrom.com)

[@nystrorm](https://twitter.com/nystrorm)

##License

Copyright (C) 2012 Ryan Nystrom

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
