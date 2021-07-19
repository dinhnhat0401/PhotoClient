# PhotoClient
MVVM + RxSwift + Unit testing

### Architecture pattern

- MVVM

### Used frameworks & tools

- RxSwift - Observable 
- Quick + Nimble - Unit test
- Swinject - Dependency injection
- SnapKit - Autolayout
- Alamofire - HTTP networking library and JSON serialization
- SwiftyJSON - map dictionary object to Entity object

- Carthage - Dependency manage tool
- SwiftLint - To be implemented

### Installation

```
cd path/to/Photoclient
carthage update --no-use-binaries --platform iOS
open PhotoClient.xcodeproj
```

To run project:

`Command` + R

To run tests: 

`Command` + U

![](https://i.imgur.com/aYkEqQO.gif)

### Requirements

- Swift 5.0
- Xcode 11.2.1+ 


### References

All test cases and project construction come from below post:
https://yoichitgy.github.io/post/dependency-injection-in-mvvm-architecture-with-reactivecocoa-part-5-asynchronous-image-load/
