//
//  TPSDropDown.h
//
//  Created by Dmytro Zavgorodniy on 12/7/16
//  Copyright (c) 2016 Tipsi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPSDropDown;

@protocol TPSDropDownDelegate <NSObject>

@optional

/// Called when the dropdown was expanded.
- (void)dropDownDidOpen:(TPSDropDown *)dropDown;

/// Called when the dropdown did dismiss.
- (void)dropDownDidClose:(TPSDropDown *)dropDown;

/// Called when a row was tapped in dropdown.
- (void)dropDown:(TPSDropDown *)dropDown didSelectItemAtIndex:(NSInteger)index;

@end

@protocol TPSDropDownItem <NSObject>

@required

/// Title, which will show in dropdown.
- (NSString *)title;

/// Attributed Title, which will show in dropdown.
- (NSAttributedString *)attributedTitle;

/// Icon
- (NSString*)iconName;
@end

@interface TPSDropDown : UIView

/// Array of any objects, which conforms to TPSDropDownItem protocol, which will be showed in dropdown. When you set new items, you should update selectedItemIndex yourself. By the way, you can set array with any objects, even if this objects doesn't conforms to TPSDropDownItem protocol, in this case we don't show titles for this objects in dropdown.
/// Default = @[].
@property (nonatomic, strong) NSArray <id <TPSDropDownItem>> *items;

/// Index of select item. When it's equal to NSNotFound, this means, that dropdown doesn't has selected item.
/// Default = NSNotFound.
@property (nonatomic, assign) NSInteger selectedItemIndex;

/// Default = nil.
@property (nonatomic, weak) IBOutlet id <TPSDropDownDelegate> delegate;

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

///Expand DropDown
- (void)openDropDown:(BOOL)animated;

///Close DropDown
- (void)closeDropDown:(BOOL)animated;
@end
