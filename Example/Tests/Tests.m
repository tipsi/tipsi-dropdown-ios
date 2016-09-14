//
//  TPSDropDownTests.m
//  TPSDropDownTests
//
//  Created by Sergey Yuzepovich on 08/01/2016.
//  Copyright (c) 2016 Sergey Yuzepovich. All rights reserved.
//

#import "TPSDropdownList.h"
#import "TPSRoundDropdown.h"
#import "TPSSquareDropdown.h"

#define RECORDING   NO

SpecBegin(InitialSpecs)

describe(@"Simple Tests", ^{
    __block TPSDropdownList *simpleDropdown;

    beforeAll(^{
        simpleDropdown = [[TPSDropdownList alloc] init];
        [simpleDropdown setupWithElements:@[@"One",@"Two",@"Three"]];
    });
    it(@"can select item", ^{
        [simpleDropdown pickElementAtIndex:1];
        expect([simpleDropdown getCurrentItem]).equal(@"Two");
        expect(simpleDropdown.selectedIndex).equal(1);
    });
    //TODO: other tests
    afterAll(^{
        simpleDropdown = nil;
    });
});

describe(@"Snapshots tests",^{
    __block TPSDropdownList *simpleDropdown;
    
    beforeAll(^{
        simpleDropdown = [[TPSDropdownList alloc] initWithFrame:CGRectMake(0,0,200,30)];
        [simpleDropdown setupWithElements:@[@"One",@"Two",@"Three"]];
    });
    it(@"has valid snapshot", ^{
        NSString *snapName = @"TPSDropdownListClosed";
        if(RECORDING){
            expect(simpleDropdown).toNot.recordSnapshotNamed(snapName);
        }
        else{
            expect(simpleDropdown).to.to.haveValidSnapshotNamed(snapName);
        }
    });
    //TODO: other snapshots tests
    afterAll(^{
        simpleDropdown = nil;
    });
});

SpecEnd
