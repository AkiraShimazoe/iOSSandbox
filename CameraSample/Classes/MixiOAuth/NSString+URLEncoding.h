//
//  NSString+URLEncoding.h
//  MixiOAuthSample
//
//  Created by 中村 薫 on 10/12/30.
//  Copyright 2010 personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncoding)
-(NSString *)stringByURLEncoding:(NSStringEncoding)encoding;
@end
