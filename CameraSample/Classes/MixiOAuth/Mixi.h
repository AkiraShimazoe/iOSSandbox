//
//  Mixi.h
//  MixiOAuthSample
//
//  Created by 中村 薫 on 10/12/30.
//  Copyright 2010 personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuthConsumer.h"

@interface Mixi : NSObject
{
	OAuthConsumer *consumer;
}

-(id)init:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret;
-(NSString *)getAauthorizeRequestURL:(NSString *)scope;
-(NSString *)getAccessToken:(NSString *)code redirectURI:(NSString *)redirectURI;
-(void)setAccessToken:(NSString *)accessToken;
-(NSDictionary *)getPeople;
-(void)postVoice:(NSString *)post;
-(void)postVoiceWithPhoto:(NSString *)post photo:(NSString *)photo;
-(void)postVoiceWithPhotoData:(NSString *)post photo:(NSData *)photo fileName:(NSString *)fileName;
@end

