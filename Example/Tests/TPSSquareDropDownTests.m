//
//  TPSSquareDropDownTests.m
//  TPSDropDown
//
//  Created by Dmytro Zavgorodniy on 12/7/16.
//  Copyright © 2016 Tipsi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <TPSDropDown/TPSSquareDropDown.h>
#import <FBSnapshotTestCase/UIImage+Compare.h>

@interface TPSSquareDropDownTests : XCTestCase

@property (nonatomic, strong) TPSSquareDropDown *sut;

@end

@implementation TPSSquareDropDownTests

#pragma mark - XCTestCase

- (void)setUp {
    [super setUp];
    
    self.sut = [[TPSSquareDropDown alloc] initWithFrame:CGRectMake(50.f, 50.f, 100.f, 100.f)];
}

- (void)tearDown {
    self.sut = nil;
    
    [super tearDown];
}

#pragma mark - Tests

- (void)testSquareDropDownInitializedWithFrameShouldNotBeNil {
    XCTAssertNotNil(self.sut);
}

- (void)testSquareDropDownShouldBeKindOfDropDownClass {
    XCTAssertTrue([self.sut isKindOfClass:[TPSDropDown class]]);
}

- (void)testSquareDropDownBorderWidthShouldHasDefaultValue {
    XCTAssertEqualWithAccuracy(self.sut.borderWidth, 1.f, 0.001);
}

- (void)testSquareDropDownSeparatorWidthShouldHasDefaultValue {
    XCTAssertEqualWithAccuracy(self.sut.separatorWidth, 1.f, 0.001);
}

- (void)testSquareDropDownSeparatorColorShouldHasDefaultValue {
    XCTAssertEqualObjects(self.sut.separatorColor, [UIColor whiteColor]);
}

- (void)testSquareDropDownFontShouldHasDefaultValue {
    UIFont *font = [UIFont fontWithName:@"TheSerif-Regular" size:16.f];
    XCTAssertNotNil(self.sut.font);
    XCTAssertEqualObjects(self.sut.font.fontName, font.fontName);
    XCTAssertEqualWithAccuracy(self.sut.font.pointSize, font.pointSize, 0.001);
}

- (void)testSquareDropDownTextAlignmentShouldHasDefaultValue {
    XCTAssertEqual(self.sut.textAlignment, NSTextAlignmentLeft);
}

- (void)testSquareDropDownIndicatorImageShouldHasDefaultValue {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self.sut class]] pathForResource:@"TPSDropDownBundle" ofType:@"bundle"]];
    UIImage *indicatorImage = [UIImage imageNamed:@"square_drop_down_indicator_image" inBundle:bundle compatibleWithTraitCollection:nil];
    
    XCTAssertNotNil(self.sut.indicatorImage);
    XCTAssertTrue([self.sut.indicatorImage fb_compareWithImage:indicatorImage tolerance:0.f]);
}

- (void)testSquareDropDownBorderColorShouldHasDefaultValue {
    XCTAssertEqualObjects(self.sut.borderColor, [UIColor colorWithRed:232.f/255.f green:228.f/255.f blue:223.f/255.f alpha:1.f]);
}

@end
