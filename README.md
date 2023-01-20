# VivUIExtensions

Reusable UIKit Extensions and Configs

## Using VivUIExtensions

#### Swift Package Manager

Simply add the package dependency to your `Package.swift`:

```swift
dependencies: [
  .package(url: "https://github.com/VPhung24/VivUIExtensions.git", from: "1.0.4")
]
```

...and depend on `"VivUIExtensions"` in the necessary targets:

```swift
.target(
  name: ...,
  dependencies: [.product(name: "VivUIExtensions", package: "VivUIExtensions")]
]
```

#### Xcode

From Xcode 11 it is possible to [add Swift Package dependencies to Xcode projects][xcode-spm] and link targets to products of those packages; this is the easiest way to integrate VivUIExtensions Swift with an existing `xcodeproj`.
