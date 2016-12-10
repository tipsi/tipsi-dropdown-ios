//
//  TPSRoundDropDownTests.m
//  TPSDropDown
//
//  Created by Dmytro Zavgorodniy on 12/7/16.
//  Copyright © 2016 Tipsi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <TPSDropDown/TPSRoundDropDown.h>
#import <FBSnapshotTestCase/UIImage+Compare.h>

@interface TPSRoundDropDownTests : XCTestCase

@property (nonatomic, strong) TPSRoundDropDown *sut;

@end

@implementation TPSRoundDropDownTests

#pragma mark - XCTestCase

- (void)setUp {
    [super setUp];
    
    self.sut = [[TPSRoundDropDown alloc] initWithFrame:CGRectMake(50.f, 50.f, 100.f, 100.f)];
}

- (void)tearDown {
    self.sut = nil;
    
    [super tearDown];
}

#pragma mark - Tests

- (void)testRoundDropDownInitializedWithFrameShouldNotBeNil {
    XCTAssertNotNil(self.sut);
}

- (void)testRoundDropDownShouldBeKindOfDropDownClass {
    XCTAssertTrue([self.sut isKindOfClass:[TPSDropDown class]]);
}

- (void)testRoundDropDownCornerRadiusShouldHasDefaultValue {
    XCTAssertEqualWithAccuracy(self.sut.cornerRadius, 50.f, 0.001);
}

- (void)testRoundDropDownCornerRadiusShouldChangeWhenFrameDidChange {
    self.sut.frame = CGRectMake(50.f, 50.f, 200.f, 200.f);
    XCTAssertEqualWithAccuracy(self.sut.cornerRadius, 100.f, 0.001);
}

- (void)testRoundDropDownBackgroundColorShouldHasDefaultValue {
    UIColor *backgroundColor = [UIColor colorWithRed:170.f/255.f green:170.f/255.f blue:170.f/255.f alpha:1.f];
    XCTAssertEqualObjects(self.sut.backgroundColor, backgroundColor);
}

- (void)testRoundDropDownBorderWidthShouldHasDefaultValue {
    XCTAssertEqualWithAccuracy(self.sut.borderWidth, 0.f, 0.001);
}

- (void)testRoundDropDownSeparatorWidthShouldHasDefaultValue {
    XCTAssertEqualWithAccuracy(self.sut.separatorWidth, 1.f, 0.001);
}

- (void)testRoundDropDownFontShouldHasDefaultValue {
    UIFont *font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14.f];
    XCTAssertNotNil(self.sut.font);
    XCTAssertEqualObjects(self.sut.font.fontName, font.fontName);
    XCTAssertEqualWithAccuracy(self.sut.font.pointSize, font.pointSize, 0.001);
}

- (void)testRoundDropDownTextColorShouldHasDefaultValue {
    XCTAssertEqualObjects(self.sut.textColor, [UIColor whiteColor]);
}

- (void)testRoundDropDownSeparatorColorShouldHasDefaultValue {
    XCTAssertEqualObjects(self.sut.separatorColor, [UIColor colorWithRed:170.f/255.f green:170.f/255.f blue:170.f/255.f alpha:1.f]);
}

- (void)testRoundDropDownTextAlignmentShouldHasDefaultValue {
    XCTAssertEqual(self.sut.textAlignment, NSTextAlignmentLeft);
}

- (void)testRoundDropDownIndicatorImageShouldHasDefaultValue {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self.sut class]] pathForResource:@"TPSDropDownBundle" ofType:@"bundle"]];
    UIImage *indicatorImage = [UIImage imageNamed:@"round_drop_down_indicator_image" inBundle:bundle compatibleWithTraitCollection:nil];
    
    XCTAssertNotNil(self.sut.indicatorImage);
    XCTAssertTrue([self.sut.indicatorImage fb_compareWithImage:indicatorImage tolerance:0.f]);
}

@end
