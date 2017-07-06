# BannerView
Simple Banner View that automatically scrolls.

|             English localization     |           Arabic localization        |
|--------------------------------------|--------------------------------------|
|![Demo](https://github.com/MagicLab-team/BannerView/blob/master/BannerViewExample/Demo_en.gif)|![Demo](https://github.com/MagicLab-team/BannerView/blob/master/BannerViewExample/Demo_ar.gif)|

## Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [TODO](#todo)
- [License](#license)

## Requirements

- iOS 8.0+
- Xcode 8.0+
- Swift 3.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build Reusable 1.0.0+.

To integrate BannerView into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'MLBannerView'
end
```

Then, run the following command:

```bash
$ pod install
```

# Usage

To add BannerView you may set class to view as BannerView in storyboard or create it manually from code.

## Setup banner view:

```swift
bannerView.setup(
  type: BannerViewScrollType.fromStart,
  timeForOneItem: 1,
  bannerItems: [
    BannerItem(image: UIImage(named: "banner_1")),
    BannerItem(image: UIImage(named: "banner_2")),
    BannerItem(image: UIImage(named: "banner_3"))
  ],
  delegate: self
)
```

## BannerViewDelegate

BannerViewDelegate allows you to be notifed when banner scrolls to next item or when user clicks on item.
```swift
@objc public protocol BannerViewDelegate {
    
    @objc optional func bannerView(bannerView: BannerView, didScrollTo: BannerItem, with index: Int)
    
    @objc optional func bannerView(bannerView: BannerView, didSelectItem: BannerItem, with index: Int)
}
```

## There are three possible scroll types

```swift
public enum BannerViewScrollType {
    case fromStart
    case reverse
    case alwaysForward
}
```

|             .fromStart          |           .reverse                        |      .alwaysForward                       |
|---------------------------------|-------------------------------------------|-------------------------------------------|
|![Demo](https://github.com/MagicLab-team/BannerView/blob/master/BannerViewExample/Demo_fromStart.gif)|![Demo](https://github.com/MagicLab-team/BannerView/blob/master/BannerViewExample/Demo_reverse.gif)|![Demo](https://github.com/MagicLab-team/BannerView/blob/master/BannerViewExample/Demo_alwaysForward.gif)|

## BannerPageControl

You may access bannerPageControl through public property

```swift
bannerView.pageControl.color = UIColor.black
bannerView.pageControl.currentPageColor = UIColor.green
```

## See more about localization
[Localizable](https://github.com/romansorochak/Localizable)

## TODO

- Shifting of authomatically scrolling when user interacts
- Ability to set cell (ability to set image asynchronous)

## License

Reusable is released under the MIT license. See [LICENSE](https://github.com/MagicLab-team/BannerView/blob/master/LICENSE) for details.
