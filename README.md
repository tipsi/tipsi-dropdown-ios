# TPSDropDown

[![CI Status](https://img.shields.io/travis/tipsi/tipsi-dropdown-ios.svg?style=flat)](https://travis-ci.org/tipsi/tipsi-dropdown-ios)
[![Version](https://img.shields.io/cocoapods/v/TPSDropDown.svg?style=flat)](http://cocoapods.org/pods/TPSDropDown)
[![License](https://img.shields.io/cocoapods/l/TPSDropDown.svg?style=flat)](http://cocoapods.org/pods/TPSDropDown)
[![Platform](https://img.shields.io/cocoapods/p/TPSDropDown.svg?style=flat)](http://cocoapods.org/pods/TPSDropDown)

Tispi DropDown component.
The heart of Tispi DropDown component is [MKDropdownMenu](https://github.com/maxkonovalov/MKDropdownMenu). We are using our fork [TPSMKDropdownMenu](https://github.com/tipsi/MKDropdownMenu), but special thanks to [maxkonovalov](https://github.com/maxkonovalov) for his component.    

## Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation
### CocoaPods

`TPSDropDown` is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TPSDropDown', '~> 1.0'
```

## Usage
See the example Xcode workspace.

### Basic setup

Create the `TPSDropDown` instance and add it as a subview to your view. Set the `delegate` property to your view controller implementing `TPSDropDownDelegate` protocol.

```objc
TPSDropDown *dropDown = [[TPSDropDown alloc] initWithFrame:CGRectMake(0.f, 64.f, 320.f, 44.f)];
dropDown.items = @[@"One", @"Two", @"Three"];
dropDown.selectedItemIndex = 0;
dropDown.delegate = self;

[self.view addSubview:dropDown];
```

You can set to `items` property array of any objects, which conforms to `TPSDropDownItem` protocol, which will be showed in dropdown. When you set new items, you should update `selectedItemIndex` yourself.

By the way, you can set array with any objects, even if this objects doesn't conforms to `TPSDropDownItem` protocol, in this case we don't show titles for this objects in dropdown.

```objc
@protocol TPSDropDownItem <NSObject>

@required

/// Title, which will show in dropdown.
- (NSString *)title;

@end
```

We provides category with implementation `TPSDropDownItem` protocol for `NSSString`.

We also provides two subclass with our default appearance. You can check `TPSRoundDropDown` and `TPSSquareDropDown`.

### Interface Builder

You can also set up the `TPSDropDown` in Interface Builder.

- Add a `UIView` and set its class to `TPSDropDown` in the Identity inspector.
- Connect the `delegate` outlets to your view controller.

### Customizations

```objc
/// The corner radius of the dropdown.
/// Default = 0.f.
@property (nonatomic, assign) CGFloat cornerRadius;

/// The border around the dropdown.
/// Default = 0.f.
@property (nonatomic, assign) CGFloat borderWidth;

/// The border around the dropdown.
/// Default = [UIColor clearColor].
@property (nonatomic, strong) UIColor *borderColor;

/// The height of the dropdown rows separators (horizontal lines).
/// Default = 1.f.
@property (nonatomic, assign) CGFloat separatorWidth;

/// The color of the dropdown rows separators (horizontal lines).
/// Default = [UIColor lightGrayColor].
@property (nonatomic, strong) UIColor *separatorColor;

/// The accessory image in the header components, rotates to indicate open/closed state. Provide an image with `UIImageRenderingModeAlwaysTemplate` to respect the view's tint color.
/// Default = nil.
@property (nonatomic, strong) UIImage *indicatorImage;

/// The rotation angle (in radians) of the disclosure indicator when the component is selected.
/// Default = 0.f.
@property (nonatomic, assign) CGFloat indicatorImageSelectionRotation;

/// The font of the label for selected item.
/// The font of the labels in rows.
/// Default = [UIFont systemFontOfSize:[UIFont systemFontSize]].
@property (nonatomic, strong) UIFont *font;

/// The alignment of the label for selected item.
/// The alignment of the labels in rows.
/// Default = NSTextAlignmentLeft.
@property (nonatomic, assign) NSTextAlignment textAlignment;

/// The text color of the label for selected item.
/// The text color of the labels in rows.
/// Default = [UIColor blackColor].
@property (nonatomic, strong) UIColor *textColor;

/// Show a shadow under the dropdown.
/// Default = NO.
@property (nonatomic, assign) BOOL showShadow;
```

## Requirements
- iOS 8+
- Xcode 8+

## Author
Tipsi team

## License
`TPSDropDown` is available under the MIT license. See the LICENSE file for more info.
