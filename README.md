# TPSDropDown

[![CI Status](https://img.shields.io/travis/tipsi/tipsi-dropdown-ios.svg?style=flat)](https://travis-ci.org/tipsi/tipsi-dropdown-ios)
[![Version](https://img.shields.io/cocoapods/v/TPSDropDown.svg?style=flat)](http://cocoapods.org/pods/TPSDropDown)
[![License](https://img.shields.io/cocoapods/l/TPSDropDown.svg?style=flat)](http://cocoapods.org/pods/TPSDropDown)
[![Platform](https://img.shields.io/cocoapods/p/TPSDropDown.svg?style=flat)](http://cocoapods.org/pods/TPSDropDown)

## Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Dependencies
* POP
* Specta, Expecta, FBSnapshotTestCase (for testing only)

## Installation
TPSDropDown is available via [CocoaPods](http://cocoapods.org). To install it add the following line to your Podfile:

```ruby
    pod 'TPSDropDown'
```

## Customization
In near future dropdown will support customization using the following format (json):

```json
{
"style":
	{"backgroundColor":"0x000000",
	"borderWidth":2,
	"borderColor":"0xFFFFFF",
	"cornerRadius":10,
	"separatorWidth":1,
	"separatorColor":"0xAAAAAA",
	"fontName":"Arial",
	"textColor":"0xCCCCCC",
	"textAlignment":"Left"|"Right"|"Center",
	"indicatorImageName":"customTriangle.png"|nil
	}
}
```

## Author

Tipsi team

## License

TPSDropDown is available under the MIT license. See the LICENSE file for more info.
