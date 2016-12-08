//
//  TPSNSStringTPSDropDownItemTests.m
//  TPSDropDown
//
//  Created by Dmytro Zavgorodniy on 12/7/16.
//  Copyright © 2016 Tipsi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <TPSDropDown/TPSDropDown.h>
#import <TPSDropDown/NSString+TPSDropDownItem.h>

@interface TPSNSStringTPSDropDownItemTests : XCTestCase

@end

@implementation TPSNSStringTPSDropDownItemTests

#pragma mark - Tests

- (void)testInstanceOfNSStringShouldConformsToTPSDropDownItemProtocol {
    NSString *sut = [[NSString alloc] init];
    XCTAssertTrue([sut conformsToProtocol:@protocol(TPSDropDownItem)]);
}

- (void)testInstanceOfNSStringShouldImplementTitle {
    NSString *sut = [[NSString alloc] init];
    XCTAssertTrue([sut respondsToSelector:@selector(title)]);
}

- (void)testInstanceOfNSStringShouldReturnSelfInTPSDropDownItemTitleMethod {
    NSString *string = @"string";
    NSString *sut = [string title];
    XCTAssertEqualObjects(sut, string);
}

@end
