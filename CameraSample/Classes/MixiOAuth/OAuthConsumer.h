//
//  OAuthConsumer.h
//  MixiOAuthSample
//
//  Created by 中村 薫 on 10/12/30.
//  Copyright 2010 personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuthConsumer : NSObject
{
	NSString *consumerKey;
	NSString *consumerSecret;
	NSString *token;
	NSString *tokenSecret;
}

-(id)init:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret;
-(NSString *)getConsumerKey;
-(NSString *)getConsumerSecret;

-(void)setAccessToken:(NSString *)token tokenSecret:(NSString *)tokenSecret;
-(NSString *)getToken;
-(NSString *)getTokenSecret;

@end
