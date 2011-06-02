//
//  StatusXMLParser.m
//  TwitterViewer
//
//  Created by 中村 薫 on 10/12/21.
//  Copyright 2010 personal. All rights reserved.
//

#import "StatusXMLParser.h"


@implementation StatusXMLParser

@synthesize currentXpath, statuses, currentStatus, textNodeCharacters;

// (9)
- (void) parserDidStartDocument:(NSXMLParser *)parer {
	NSLog( @"parserDidStartDocument" );
	self.currentXpath = [[[NSMutableString alloc] init] autorelease];
	self.statuses = [[[NSMutableArray alloc] init] autorelease];
}

// (10)
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	//NSLog( @"didStartElement:%@", elementName );
	[self.currentXpath appendString: elementName];
	[self.currentXpath appendString: @"/"];

	self.textNodeCharacters = [[[NSMutableString alloc] init] autorelease];
	
	if ([self.currentXpath isEqualToString: @"statuses/status/"]) {
		self.currentStatus = [[[NSMutableDictionary alloc] init] autorelease];
	}
}

// (11)
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	NSString *textData = [self.textNodeCharacters stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	//NSLog( @"didEndElement:%@[%@]", elementName, textData );
	
	if ([self.currentXpath isEqualToString:@"statuses/status/"]) {
		[self.statuses addObject:self.currentStatus];
		self.currentStatus = nil;
	} else if ([self.currentXpath isEqualToString:@"statuses/status/text/"]) {
		[self.currentStatus setValue:textData forKey:@"text"];
	} else if ([self.currentXpath isEqualToString:@"statuses/status/user/name/"]) {
		[self.currentStatus setValue:textData forKey:@"name"];
	}

	int delLength = [elementName length] + 1;
	int delIndex = [self.currentXpath length] - delLength;
	
	[self.currentXpath deleteCharactersInRange:NSMakeRange(delIndex,delLength)];
}

// (12)
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	[self.textNodeCharacters appendString:string];
	// NSLog( @"foundCharacters:%@:[%@]", string, self.textNodeCharacters );
}

// (13)
- (NSArray *) parseStatuses:(NSData *)xml {
	NSLog( @"parseStatuses" );
	NSXMLParser *parser = [[[NSXMLParser alloc] initWithData:xml] autorelease];
	[parser setDelegate:self];
	[parser parse];
	
	return self.statuses;
}

// (14)
- (void) dealloc {
	[currentXpath release];
	[statuses release];
	[currentStatus release];
	[textNodeCharacters release];
	
	[super dealloc];
}

@end
