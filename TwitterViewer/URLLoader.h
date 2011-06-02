//
//  URLLoader.h
//  TwitterViewer
//
//  Created by 中村 薫 on 10/12/21.
//  Copyright 2010 personal. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface URLLoader : NSObject {
	NSURLConnection	*connection;
	NSMutableData	*data;
}

@property(retain,nonatomic) NSURLConnection	*connection;
@property(retain,nonatomic) NSMutableData	*data;

- (void) loadFromUrl: (NSString *)url method:(NSString *)method;

@end
