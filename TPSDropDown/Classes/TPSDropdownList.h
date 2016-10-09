//
//  TPSDropdownList.h
//  Tipsi EE
//
//  Created by Sergey Yuzepovich on 06.04.15.
//  Copyright (c) 2015 RostDS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPSDropdownList;

@protocol DropdownDelegate <NSObject>
@optional
- (void)dropdown:(TPSDropdownList*)dropdown didSelectItemAtIndex:(NSUInteger)index withValue:(NSString*)itemValue;
- (void)dropdown:(TPSDropdownList *)dropdown willChangeExpandedState:(BOOL)state;
@end

@interface TPSDropdownList : UIControl
@property(weak,nonatomic) IBOutlet id<DropdownDelegate> delegate;
@property(assign,nonatomic) CGFloat maximumHeight;
@property(assign,nonatomic) BOOL showCheckmark;
@property(readonly,nonatomic) NSUInteger selectedIndex;
- (void)setupWithElements:(NSArray *)rows;
- (void)selectElementWithName:(id)name;
- (void)pickElementAtIndex:(NSUInteger)index;
- (void)closeDropdown;
- (void)resetFirstElement;
- (NSString *)getCurrentItem;
- (NSUInteger)elementHeight;
- (void)applyStyleJson:(NSString*)jsonStyles;
- (void)applyStyleDictionary:(NSDictionary*)dictStyles;
+ (instancetype)dropdownWithStyle:(NSString*)jsonStyles;
- (void)initArrowWithImage:(UIImage*)arrowImage;
@end
