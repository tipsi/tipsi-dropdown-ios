//
//  TPSNSAttributedStringTPSDropDownItemTests.m
//  TPSDropDown
//
//  Created by Denys on 12/29/16.
//  Copyright © 2016 Tipsi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <TPSDropDown/TPSDropDown.h>
#import <TPSDropDown/NSAttributedString+TPSDropDownItem.h>

@interface TPSNSAttributedStringTPSDropDownItemTests : XCTestCase

@end

@implementation TPSNSAttributedStringTPSDropDownItemTests

#pragma mark - Tests

- (void)testInstanceOfNSAttributedStringShouldConformsToTPSDropDownItemProtocol {
    NSAttributedString *sut = [[NSAttributedString alloc] init];
    XCTAssertTrue([sut conformsToProtocol:@protocol(TPSDropDownItem)]);
}

- (void)testInstanceOfNSAttributedStringShouldImplementTitle {
    NSAttributedString *sut = [[NSAttributedString alloc] init];
    XCTAssertTrue([sut respondsToSelector:@selector(title)]);
}

- (void)testInstanceOfNSAttributedStringShouldReturnNilInTPSDropDownItemTitleMethod {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"string"];
    NSString *sut = [string title];
    XCTAssertNil(sut);
}

- (void)testInstanceOfNSAttributedStringShouldImplementAttributedTitle {
    NSAttributedString *sut = [[NSAttributedString alloc] init];
    XCTAssertTrue([sut respondsToSelector:@selector(attributedTitle)]);
}

- (void)testInstanceOfNSAttributedStringShouldReturnSelfInTPSDropDownItemAttributedTitleMethod {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"string"];
    NSAttributedString *sut = [string attributedTitle];
    XCTAssertEqualObjects(sut, string);
}

- (void)testInstanceOfNSAttributedStringShouldImplementIconName {
    NSAttributedString *sut = [[NSAttributedString alloc] init];
    XCTAssertTrue([sut respondsToSelector:@selector(iconName)]);
}

- (void)testInstanceOfNSAttributedStringShouldReturnNilInTPSDropDownItemIconName {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"string"];
    NSString *sut = [string iconName];
    XCTAssertNil(sut);
}

@end
