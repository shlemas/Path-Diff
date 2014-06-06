//
//  Path_DiffTests.m
//  Path DiffTests
//
//  Created by Shawn LeMaster on 6/5/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PDDiff.h"
#import "PDDPathArray.h"

@interface Path_DiffTests : XCTestCase

@end

@implementation Path_DiffTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPDDPaths
{
    PDDPathArray *dPaths = [[PDDPathArray alloc] initWithNumberOfKLines:5];

    [dPaths setXValue:-2 forKLine:-2];
    [dPaths setXValue:-1 forKLine:-1];
    [dPaths setXValue: 0 forKLine: 0];
    [dPaths setXValue: 1 forKLine: 1];
    [dPaths setXValue: 2 forKLine: 2];

    XCTAssertEqual([dPaths numberOfKLines], 5);
    XCTAssertEqual([dPaths xValueForKLine:-2], -2);
    XCTAssertEqual([dPaths xValueForKLine:-1], -1);
    XCTAssertEqual([dPaths xValueForKLine: 0],  0);
    XCTAssertEqual([dPaths xValueForKLine: 1],  1);
    XCTAssertEqual([dPaths xValueForKLine: 2],  2);
}

- (void)testPDDiffEmptyStrings
{
    PDDiff *diff = [PDDiff new];
    XCTAssertEqual([diff differenceBetweenString:@""
                                       andString:@""], 0);
}

- (void)testPDDiffEmptyStringAndString
{
    PDDiff *diff = [PDDiff new];
    XCTAssertEqual([diff differenceBetweenString:@""
                                       andString:@"123"], 3);
}

- (void)testPDDiffStringAndEmptyString
{
    PDDiff *diff = [PDDiff new];
    XCTAssertEqual([diff differenceBetweenString:@"456"
                                       andString:@""], 3);
}

- (void)testPDDiffEqualStrings
{
    PDDiff *diff = [PDDiff new];
    XCTAssertEqual([diff differenceBetweenString:@"foo"
                                       andString:@"foo"], 0);
}

- (void)testPDDiffCompletelyDifferentStrings
{
    PDDiff *diff = [PDDiff new];
    XCTAssertEqual([diff differenceBetweenString:@"foo"
                                       andString:@"bar"], 6);
}

- (void)testPDDiffDelete
{
    PDDiff *diff = [PDDiff new];
    XCTAssertEqual([diff differenceBetweenString:@"hey"
                                       andString:@"he"], 1);
}

- (void)testPDDiffInsert
{
    PDDiff *diff = [PDDiff new];
    XCTAssertEqual([diff differenceBetweenString:@"the"
                                       andString:@"then"], 1);
}

- (void)testPDDiffDeleteInsert
{
    PDDiff *diff = [PDDiff new];
    XCTAssertEqual([diff differenceBetweenString:@"too"
                                       andString:@"two"], 2);
}

@end
