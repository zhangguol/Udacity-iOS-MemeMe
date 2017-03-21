# ViewControllerTestable
[![Travis branch](https://img.shields.io/travis/zhangguol/ViewControllerTestable/master.svg?style=flat-square)](https://travis-ci.org/zhangguol/ViewControllerTestable)
[![Codecov branch](https://img.shields.io/codecov/c/github/zhangguol/ViewControllerTestable/master.svg?style=flat-square)](https://codecov.io/gh/zhangguol/ViewControllerTestable)
[![license](https://img.shields.io/github/license/zhangguol/ViewControllerTestable.svg?style=flat-square)](./LICENSE)
## What is it?
ViewControllerTestable is an extension to make a `UIViewController` testable with `present`, `dismiss`, and `push`

## Requirements
- iOS 10.0+
- Swift 3

## Installation

### CocoaPods

Add the following to your Podfile.

```
pod "ViewControllerTestable", `~> 0.1.2`
```

### Git Submodule
```
git submodule add https://github.com/zhangguol/ViewControllerTestable
```

## Usage

### Make a `UIViewController` testable

You need to `import UIViewControllerTestable` at first.

To make a `UIViewController` testable, just make it implement `UIViewControllerTestable` protocol

```swift
extension DemoUIViewController: UIViewControllerTestable {}
```

Then use

```swift
func present(_ viewController: UIViewController,
             from aViewController: UIViewController,
             animated: Bool,
             completion: (() -> Void)?)
```
to present a view controller. Or use

```swift
func dismiss(_ viewController: UIViewController,
             animated: Bool,
             completion: (() -> Void)?)

```
to dismiss a view controller. Also can use

```swift
func push(_ viewController: UIViewController,
          in navigationControler: UINavigationController,
          animated: Bool)
```
to push a view controller into a `UINavigationController`

### How to test a view controller

Set the view controller's `viewControllerPresent` to an instance of `MockViewControllerPresenter`

```swift
let mockPresenter = MockViewControllerPresenter()
viewController.viewControllerPresenter = mockPresenter
```

## Other

### License
ViewControllerTestable is released under the MIT license. See [LICENSE](./LICENSE) for details.

