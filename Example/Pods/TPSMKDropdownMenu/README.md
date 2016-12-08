# Tipsi Team

Special thanks to [maxkonovalov](https://github.com/maxkonovalov) for his component.    

We changed internal view hierarchy for our need.

Also we added a few additional properties for appearance customization:

- Dropdown Border Width – ability to set width of border in dropdown menu and dropdown view. Default value = 0.f.
```objective-c
@property (assign, nonatomic) CGFloat dropdownBorderWidth UI_APPEARANCE_SELECTOR;
```

- Dropdown Border Color – ability to set color of border in dropdown menu and dropdown view. Default value = [UIColor clearColor].
```objective-c
@property (nullable, strong, nonatomic) UIColor *dropdownBorderColor UI_APPEARANCE_SELECTOR;
```

- Row Separator Width – ability to set width of row separator in dropdown view. Default value = 1.f. Note: this feature doesn't implemented in version 1.3.1, we added only interface. Please check our updates.
```objective-c
@property (assign, nonatomic) CGFloat rowSeparatorWidth UI_APPEARANCE_SELECTOR;
```

- Background Color – override setter, we also apply this background in dropdown view.
```objective-c
@property (nullable, nonatomic, copy) UIColor *backgroundColor UI_APPEARANCE_SELECTOR;
```

Also we don't support a few features for native implementation:

```objective-c
@property (assign, nonatomic) BOOL dropdownShowsTopRowSeparator UI_APPEARANCE_SELECTOR;
@property (assign, nonatomic) BOOL dropdownShowsBorder UI_APPEARANCE_SELECTOR;
@property (nullable, strong, nonatomic) UIView *spacerView;
@property (assign, nonatomic) UIOffset spacerViewOffset;
@property (assign, nonatomic) UIRectCorner dropdownRoundedCorners UI_APPEARANCE_SELECTOR;
```

We left this interface, but it doesn't do anything.

## Installation
### CocoaPods

`TPSMKDropdownMenu` is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TPSMKDropdownMenu', '~> 1.3'
```

For more reference please read description below.

# MKDropdownMenu

[![Build Status](https://travis-ci.org/maxkonovalov/MKDropdownMenu.svg?branch=master&style=flat)](https://travis-ci.org/maxkonovalov/MKDropdownMenu)
[![Version](https://img.shields.io/cocoapods/v/MKDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/MKDropdownMenu)
[![License](https://img.shields.io/cocoapods/l/MKDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/MKDropdownMenu)
[![Platform](https://img.shields.io/cocoapods/p/MKDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/MKDropdownMenu)

Dropdown Menu for iOS with many customizable parameters to suit any needs.

Inspired by UIPickerView.

<img src="Screenshots/MKDropdownMenu.png?raw=true" alt="MKDropdownMenu" width=320>
<img src="Screenshots/MKDropdownMenu.gif?raw=true" alt="MKDropdownMenu" width=320>

## Installation
### CocoaPods

`MKDropdownMenu` is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MKDropdownMenu'
```

### Manually

- Add `MKDropdownMenu` folder to your Xcode project.
- `#import "MKDropdownMenu.h"` in your code.

## Usage
See the example Xcode project.

### Basic setup

Create the `MKDropdownMenu` instance and add it as a subview to your view. Set the `dataSource` and `delegate` properties to your view controller implementing `MKDropdownMenuDataSource` and `MKDropdownMenuDelegate` protocols.

```objc
MKDropdownMenu *dropdownMenu = [[MKDropdownMenu alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
dropdownMenu.dataSource = self;
dropdownMenu.delegate = self;
[self.view addSubview:dropdownMenu];
```

### Interface Builder

You can also set up the `MKDropdownMenu` in Interface Builder.

- Add a `UIView` and set its class to `MKDropdownMenu` in the Identity inspector.
- Connect the `dataSource` and `delegate` outlets to your view controller.

### Populating the data

The `MKDropdownMenuDataSource` and `MKDropdownMenuDelegate` protocols APIs are inspired by the `UIPickerView` interface, so most of the methods should be familiar if you used it before.

Implement the following `dataSource` methods:

```objc
- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu;
- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component;
```

and the `delegate` methods that suit your needs. The most simple way to get started is to provide the titles for the header components and the rows in the following `delagate` methods:

```objc
- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForComponent:(NSInteger)component;
- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component;
```

You can also provide an `NSAttributedString` or custom `UIView` as the display data for `MKDropdownMenu` in the corresponding `delegate` methods.

### Customizations

The appearance and behavior of the `MKDropdownMenu` can be customized by setting its property values or implementing the corresponding `delegate` methods.

The default menu appearance can be customized throughout the app using the available `UI_APPEARANCE_SELECTOR` properties.


## Requirements
- iOS 8+
- Xcode 8+

## License
`MKDropdownMenu` is available under the MIT license. See the LICENSE file for more info.
