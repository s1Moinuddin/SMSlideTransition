# SMSlideTransition

[![CI Status](http://img.shields.io/travis/s1Moinuddin/SMSlideTransition.svg?style=flat)](https://travis-ci.org/s1Moinuddin/SMSlideTransition)
[![Version](https://img.shields.io/cocoapods/v/SMSlideTransition.svg?style=flat)](http://cocoapods.org/pods/SMSlideTransition)
[![License](https://img.shields.io/cocoapods/l/SMSlideTransition.svg?style=flat)](http://cocoapods.org/pods/SMSlideTransition)
[![Platform](https://img.shields.io/cocoapods/p/SMSlideTransition.svg?style=flat)](http://cocoapods.org/pods/SMSlideTransition)

## What you can do?
- present your viewController with slide animation
- set slide direction for left/right/top/bottom
- set presented viewController height (like Half Modal)
- set dim alpha 
- set transition duration
- allow Interaction in dismissing viewController.

## Transition slide animation
<img src="/Screenshots/SMSlideTransition.gif" />
<img src="/Screenshots/SMSlideTransitionInteraction.gif" />

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift
import SMSlideTransition
```
initialize SMSlideTransitionDelegate in class variable
```swift
let topSlideDelegate    = SMSlideTransitionDelegate()
```
setup parameter to the delegate then assign it to your viewController delegate
```swift
topSlideDelegate.slideStyle = .top
topSlideDelegate.allowInteractionOnDismissal = false
topSlideDelegate.heightOfPresentedViewController = 450
yourViewController.transitioningDelegate = topSlideDelegate
yourViewController.modalPresentationStyle = .custom
```
That's it, now present your viewController.

you can also modify bellow parameters:
```swift
topSlideDelegate.roundCorners(corners: [.topLeft, .topRight], radius: 20)
```
```swift
topSlideDelegate.dimScale = 0.7
```
```swift
topSlideDelegate.duration = 0.4
```
## Requirements
    iOS 9
    Swift 3
    Xcode 8

## Installation

SMSlideTransition is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SMSlideTransition"
```

## Author

S.M.Moinuddin, shuvn.eee@gmail.com

## License

SMSlideTransition is available under the MIT license. See the LICENSE file for more info.
