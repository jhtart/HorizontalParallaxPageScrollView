# HorizontalParallaxPageScrollView

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
 [![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
 [![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)

HorizontalParallaxPageScrollView is a page with parallex horizontally scroll effect written by pure Swift3.0

## Features

- [x] Storyboard and pure code layout
- [x] Auto scroll
- [x] Infinite scroll
- [x] WebImage and local image (It use Kingfisher to load web image)
- [x] Placeholder image

## Requirements

- iOS 8
- ARC

## Install

Todo: CocoaPod

```
just copy "HorizontalParallaxPageScrollView.swift" file
```

## Getting start

Data Source

```

```

Delegate

```

```

##Propertys

- `autoScroll` enable timer based scroll
- `autoScrollTimeInterval` scroll interval
- `enableScrollForSinglePage`  enable scroll if there is only single page
- `parllexSpeed` the speed of parallex scroll.Better to between 0.1 and 0.8
- `currentIndex` current page index.Readonly
- `pageControl` the pageControl object 
- `transitionMode` set it to .Normal if you do not want parallex scroll.

## TODO

- [x] Storyboard and pure code layout
- [x] Auto scroll
- [x] Infinite scroll
- [x] WebImage and local image (It use Kingfisher to load web image)
- [x] Placeholder image

## Author

Elon Kim

## License

HorizontalParallaxPageScrollView is available under the MIT license. See the LICENSE file for more info.
