//
//  Path_DiffTests.m
//  Path DiffTests
//
//  Created by Shawn LeMaster on 6/5/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PDDiffer.h"
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

    [dPaths setDPath:[[PDDPath alloc] initWithEndX:-2] forKLine:-2];
    [dPaths setDPath:[[PDDPath alloc] initWithEndX:-1] forKLine:-1];
    [dPaths setDPath:[[PDDPath alloc] initWithEndX: 0] forKLine: 0];
    [dPaths setDPath:[[PDDPath alloc] initWithEndX: 1] forKLine: 1];
    [dPaths setDPath:[[PDDPath alloc] initWithEndX: 2] forKLine: 2];

    XCTAssertEqual([dPaths numberOfKLines], 5);
    XCTAssertEqual([[dPaths dPathForKLine:-2] x], -2);
    XCTAssertEqual([[dPaths dPathForKLine:-1] x], -1);
    XCTAssertEqual([[dPaths dPathForKLine: 0] x],  0);
    XCTAssertEqual([[dPaths dPathForKLine: 1] x],  1);
    XCTAssertEqual([[dPaths dPathForKLine: 2] x],  2);
}

- (void)testPDDiffEmptyStrings
{
    NSArray *diffResult = [PDDiffer characterDifferencesBetweenString:@"" andString:@""];
    XCTAssertEqual([diffResult count], 1);

    PDEdit *edit = [diffResult firstObject];
    XCTAssertEqual(edit.type, PD_EQUAL);
    XCTAssertEqualObjects(edit.string, @"");
}

- (void)testPDDiffEmptyStringAndString
{
    NSArray *diffResult = [PDDiffer characterDifferencesBetweenString:@"" andString:@"123"];
    XCTAssertEqual([diffResult count], 1);

    PDEdit *edit = [diffResult firstObject];
    XCTAssertEqual(edit.type, PD_INSERT);
    XCTAssertEqualObjects(edit.string, @"123");
}

- (void)testPDDiffStringAndEmptyString
{
    NSArray *diffResult = [PDDiffer characterDifferencesBetweenString:@"456" andString:@""];
    XCTAssertEqual([diffResult count], 1);

    PDEdit *edit = [diffResult firstObject];
    XCTAssertEqual(edit.type, PD_DELETE);
    XCTAssertEqualObjects(edit.string, @"456");
}

- (void)testPDDiffEqualStrings
{
    NSArray *diffResult = [PDDiffer characterDifferencesBetweenString:@"foo" andString:@"foo"];
    XCTAssertEqual([diffResult count], 1);

    PDEdit *edit = [diffResult firstObject];
    XCTAssertEqual(edit.type, PD_EQUAL);
    XCTAssertEqualObjects(edit.string, @"foo");
}

- (void)testPDDiffCompletelyDifferentStrings
{
    NSArray *diffResult = [PDDiffer characterDifferencesBetweenString:@"foo" andString:@"bar"];
    XCTAssertEqual([diffResult count], 2);

    PDEdit *edit1 = [diffResult objectAtIndex:0];
    XCTAssertEqual(edit1.type, PD_DELETE);
    XCTAssertEqualObjects(edit1.string, @"foo");

    PDEdit *edit2 = [diffResult objectAtIndex:1];
    XCTAssertEqual(edit2.type, PD_INSERT);
    XCTAssertEqualObjects(edit2.string, @"bar");
}

- (void)testPDDiffDelete
{
    NSArray *diffResult = [PDDiffer characterDifferencesBetweenString:@"hey" andString:@"he"];
    XCTAssertEqual([diffResult count], 2);
}

- (void)testPDDiffInsert
{
    NSArray *diffResult = [PDDiffer characterDifferencesBetweenString:@"the" andString:@"then"];
    XCTAssertEqual([diffResult count], 2);
}

- (void)testPDDiffDeleteInsert
{
    NSArray *diffResult = [PDDiffer characterDifferencesBetweenString:@"too" andString:@"two"];
    XCTAssertEqual([diffResult count], 4);
}

- (void)testPDDiffLines
{
    NSString *s1 = @"Foo\nBar\nBaz";
    NSString *s2 = @"Foo\nBad\nBaz";

    NSArray *diffResult = [PDDiffer lineDifferencesBetweenString:s1 andString:s2];
    XCTAssertEqual([diffResult count], 4);
}

@end
