//
//  TPSDropDownTests.m
//  TPSDropDown
//
//  Created by Dmytro Zavgorodniy on 12/7/16.
//  Copyright © 2016 Tipsi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <TPSDropDown/TPSDropDown.h>

@interface TPSDropDownTests : XCTestCase

@property (nonatomic, strong) TPSDropDown *sut;

@end

@implementation TPSDropDownTests

#pragma mark - XCTestCase

- (void)setUp {
    [super setUp];
    
    self.sut = [[TPSDropDown alloc] initWithFrame:CGRectMake(50.f, 50.f, 100.f, 100.f)];
}

- (void)tearDown {
    self.sut = nil;
    
    [super tearDown];
}

#pragma mark - Tests

- (void)testDropDownInitializedWithFrameShouldNotBeNil {
    XCTAssertNotNil(self.sut);
}

- (void)testDropDownItemsShouldBeImplemented {
    XCTAssertTrue([self.sut respondsToSelector:@selector(items)]);
}

- (void)testDropDownItemsShouldHasDefaultValue {
    XCTAssertEqualObjects(self.sut.items, @[]);
}

- (void)testDropDownSelectedItemIndexShouldBeImplemented {
    XCTAssertTrue([self.sut respondsToSelector:@selector(selectedItemIndex)]);
}

- (void)testDropDownSelectedItemIndexShouldHasDefaultValue {
    XCTAssertEqual(self.sut.selectedItemIndex, NSNotFound);
}

- (void)testDropDownDelegateShouldBeImplemented {
    XCTAssertTrue([self.sut respondsToSelector:@selector(delegate)]);
}

- (void)testDropDownDelegateShouldHasDefaultValue {
    XCTAssertNil(self.sut.delegate);
}

- (void)testDropDownCornerRadiusShouldBeImplemented {
    XCTAssertTrue([self.sut respondsToSelector:@selector(cornerRadius)]);
}

- (void)testDropDownCornerRadiusShouldHasDefaultValue {
    XCTAssertEqualWithAccuracy(self.sut.cornerRadius, 0.f, 0.001);
}

- (void)testDropDownBorderWidthShouldBeImplemented {
    XCTAssertTrue([self.sut respondsToSelector:@selector(borderWidth)]);
}

- (void)testDropDownBorderWidthShouldHasDefaultValue {
    XCTAssertEqualWithAccuracy(self.sut.borderWidth, 0.f, 0.001);
}

- (void)testDropDownBorderColorShouldBeImplemented {
    XCTAssertTrue([self.sut respondsToSelector:@selector(borderColor)]);
}

- (void)testDropDownBorderColorShouldHasDefaultValue {
    XCTAssertEqualObjects(self.sut.borderColor, [UIColor clearColor]);
}

- (void)testDropDownSeparatorWidthShouldBeImplemented {
    XCTAssertTrue([self.sut respondsToSelector:@selector(separatorWidth)]);
}

- (void)testDropDownSeparatorWidthShouldHasDefaultValue {
    XCTAssertEqualWithAccuracy(self.sut.separatorWidth, 1.f, 0.001);
}

- (void)testDropDownSeparatorColorShouldBeImplemented {
    XCTAssertTrue([self.sut respondsToSelector:@selector(separatorColor)]);
}

- (void)testDropDownSeparatorColorShouldHasDefaultValue {
    XCTAssertEqualObjects(self.sut.separatorColor, [UIColor lightGrayColor]);
}

- (void)testDropDownIndicatorImageShouldBeImplemented {
    XCTAssertTrue([self.sut respondsToSelector:@selector(indicatorImage)]);
}

- (void)testDropDownIndicatorImageShouldHasDefaultValue {
    XCTAssertNil(self.sut.indicatorImage);
}

- (void)testDropDownIndicatorImageSelectionRotationShouldBeImplemented {
    XCTAssertTrue([self.sut respondsToSelector:@selector(indicatorImageSelectionRotation)]);
}

- (void)testDropDownIndicatorImageSelectionRotationShouldHasDefaultValue {
    XCTAssertEqualWithAccuracy(self.sut.indicatorImageSelectionRotation, 0.f, 0.001);
}

- (void)testDropDownFontShouldBeImplemented {
    XCTAssertTrue([self.sut respondsToSelector:@selector(font)]);
}

- (void)testDropDownFontShouldHasDefaultValue {
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    XCTAssertNotNil(self.sut.font);
    XCTAssertEqualObjects(self.sut.font.fontName, font.fontName);
    XCTAssertEqualWithAccuracy(self.sut.font.pointSize, font.pointSize, 0.001);
}

- (void)testDropDownTextAlignmentShouldBeImplemented {
    XCTAssertTrue([self.sut respondsToSelector:@selector(textAlignment)]);
}

- (void)testDropDownTextAlignmentShouldHasDefaultValue {
    XCTAssertEqual(self.sut.textAlignment, NSTextAlignmentLeft);
}

- (void)testDropDownTextColorShouldBeImplemented {
    XCTAssertTrue([self.sut respondsToSelector:@selector(textColor)]);
}

- (void)testDropDownTextColorShouldHasDefaultValue {
    XCTAssertEqualObjects(self.sut.textColor, [UIColor blackColor]);
}

- (void)testDropDownShowShadowShouldBeImplemented {
    XCTAssertTrue([self.sut respondsToSelector:@selector(showShadow)]);
}

- (void)testDropDownShowShadowShouldHasDefaultValue {
    XCTAssertFalse(self.sut.showShadow);
}

@end
