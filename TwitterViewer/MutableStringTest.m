//
//  MutableStringTest.m
//  TwitterViewer
//
//  Created by 中村 薫 on 10/12/23.
//  Copyright 2010 personal. All rights reserved.
//

#import "MutableStringTest.h"


@implementation MutableStringTest

- (void) testAppendString {
	NSMutableString *target = [NSMutableString stringWithString:@"なかむら"];
	NSString *added = @"かおる";
	[target appendString:added];
    STAssertTrue( [target compare:@"なかむらかおる"] == 0, target );
}


@end
