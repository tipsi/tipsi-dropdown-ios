//
//  TPSViewControllerSnapshotTests.m
//  TPSDropDown
//
//  Created by Denys on 12/29/16.
//  Copyright © 2016 Tipsi. All rights reserved.
//

#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import <TPSDropDown/TPSDropDown.h>
#import <TPSDropDown/TPSRoundDropDown.h>
#import <TPSDropDown/TPSSquareDropDown.h>
#import "TPSViewController.h"

@import UIKit;

@interface TPSDropDownSnapshotTests : FBSnapshotTestCase

@end

@implementation TPSDropDownSnapshotTests

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
    self.deviceAgnostic = YES;
}

- (void)tearDown {
    [super tearDown];
}

- (void)testRootScreen {
    UINavigationController *rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    self.usesDrawViewHierarchyInRect = YES;
    FBSnapshotVerifyView(rootViewController.view, nil);
}

- (void)testOpenTPSDropDown {
    id <UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
    UINavigationController *rootViewController = (UINavigationController*)[[delegate window] rootViewController];
    TPSViewController *viewController = (TPSViewController*)[rootViewController topViewController];
    [viewController closeAllDropDowns];
    [viewController openDropDown];
    self.usesDrawViewHierarchyInRect = YES;
    FBSnapshotVerifyView([delegate window], nil);
}

- (void)testOpenTPSDropDownWithIcon {
    id <UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
    UINavigationController *rootViewController = (UINavigationController*)[[delegate window] rootViewController];
    TPSViewController *viewController = (TPSViewController*)[rootViewController topViewController];
    [viewController closeAllDropDowns];
    [viewController openPaymentDropDown];
    self.usesDrawViewHierarchyInRect = YES;
    FBSnapshotVerifyView([delegate window], nil);
}

- (void)testTPSDropDown {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 50.f)];
    view.backgroundColor = [UIColor lightGrayColor];
    TPSDropDown *dropDown = [[TPSDropDown alloc] initWithFrame:view.bounds];
    dropDown.items = @[@"One", @"Two", @"Three"];
    dropDown.selectedItemIndex = 0;
    [dropDown setNeedsUpdateConstraints];
    [view addSubview:dropDown];
    self.usesDrawViewHierarchyInRect = YES;
    FBSnapshotVerifyView(view, nil);
}

- (void)testTPSSquareDropDown {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 50.f)];
    view.backgroundColor = [UIColor lightGrayColor];
    TPSSquareDropDown *dropDown = [[TPSSquareDropDown alloc] initWithFrame:view.bounds];
    dropDown.items = @[@"1", @"2", @"3"];
    dropDown.selectedItemIndex = 0;
    [view addSubview:dropDown];
    self.usesDrawViewHierarchyInRect = YES;
    FBSnapshotVerifyView(view, nil);
}

- (void)testTPSRoundDropDown {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 50.f)];
    view.backgroundColor = [UIColor lightGrayColor];
    TPSRoundDropDown *dropDown = [[TPSRoundDropDown alloc] initWithFrame:view.bounds];
    dropDown.items = @[@"1", @"2", @"3"];
    dropDown.selectedItemIndex = 0;
    dropDown.backgroundColor = [UIColor grayColor];
    [view addSubview:dropDown];
    self.usesDrawViewHierarchyInRect = YES;
    FBSnapshotVerifyView(view, nil);
}

@end
