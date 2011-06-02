//
//  OAuthConsumer.m
//  MixiOAuthSample
//
//  Created by 中村 薫 on 10/12/30.
//  Copyright 2010 personal. All rights reserved.
//

#import "OAuthConsumer.h"


@implementation OAuthConsumer

-(id)init:(NSString *)_consumerKey consumerSecret:(NSString *)_consumerSecret {
	consumerKey = _consumerKey;
	consumerSecret = _consumerSecret;
	token = @"";
	tokenSecret = @"";
	
	return [super init];
}

-(NSString *)getConsumerKey {
	return consumerKey;
}

-(NSString *)getConsumerSecret {
	return consumerSecret;
}

-(void)setAccessToken:(NSString *)_token tokenSecret:(NSString *)_tokenSecret {
	token = _token;
	tokenSecret = _tokenSecret;
}

-(NSString *)getToken {
	return token;
}

-(NSString *)getTokenSecret {
	return tokenSecret;
}

@end
