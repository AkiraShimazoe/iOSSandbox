//
//  Mixi.m
//  MixiOAuthSample
//
//  Created by 中村 薫 on 10/12/30.
//  Copyright 2010 personal. All rights reserved.
//

#import "Mixi.h"
#import "NSString+URLEncoding.h"
#import "JSON.h"

@implementation Mixi

-(id)init:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret {
	consumer = [[OAuthConsumer alloc]init:consumerKey consumerSecret:consumerSecret];
	
	return [super init];
}

-(NSString *)getAauthorizeRequestURL:(NSString *)scope {
	NSString *bodyString = [[[NSString alloc] initWithFormat:@"client_id=%@&response_type=code&scope=%@", [consumer getConsumerKey], scope] autorelease];
	return [[NSString alloc] initWithFormat:@"https://mixi.jp/connect_authorize.pl?%@", [bodyString stringByURLEncoding:NSUTF8StringEncoding]];
}

-(NSString *)getAccessToken:(NSString *)code redirectURI:(NSString *)redirectURI {
	NSLog(@"%s", __FUNCTION__);

	NSString *bodyString = [[[NSString alloc] initWithFormat:@"grant_type=authorization_code&client_id=%@&client_secret=%@&code=%@&redirect_uri=%@",
							 [consumer getConsumerKey], [consumer getConsumerSecret], code, redirectURI] autorelease];
	
	NSURL *url = [NSURL URLWithString:@"https://secure.mixi-platform.com/2/token"];
	NSData *body = [[NSString stringWithString:bodyString] dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:body];
    
	NSURLResponse *response = nil;
    NSError       *error    = nil;
	
    NSData *xauth_response = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString *result = [[[NSString alloc] initWithData:xauth_response encoding:NSUTF8StringEncoding] autorelease];
	NSDictionary *dict = [result JSONValue];
	[self setAccessToken:[dict objectForKey:@"access_token"]];
	return [consumer getToken];
}

-(void)setAccessToken:(NSString *)accessToken {
	[consumer setAccessToken:accessToken tokenSecret:@""];
}

-(NSDictionary *)getPeople {
	NSLog(@"%s", __FUNCTION__);

	NSURL *url = [NSURL URLWithString:@"http://api.mixi-platform.com/2/people/@me/@self"];
	NSString *header = [[NSString alloc] initWithFormat:@"OAuth %@", [consumer getToken]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:header forHTTPHeaderField:@"Authorization"];
    
	NSURLResponse *response = nil;
    NSError       *error    = nil;
	
    NSData *xauth_response = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString *result = [[[NSString alloc] initWithData:xauth_response encoding:NSUTF8StringEncoding] autorelease];
	return [result JSONValue];
}

-(void)postVoice:(NSString *)post {
	NSLog(@"%s", __FUNCTION__);

	NSURL *url = [NSURL URLWithString:@"http://api.mixi-platform.com/2/voice/statuses/update"];
	NSString *header = [[NSString alloc] initWithFormat:@"OAuth %@", [consumer getToken]];
	NSData *body = [[NSString stringWithString:[[NSString alloc] initWithFormat:@"status=%@", post]] dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:header forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:body];
    
	NSURLResponse *response = nil;
    NSError       *error    = nil;
	
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
}

-(void)postVoiceWithPhotoData:(NSString *)post photo:(NSData *)photo fileName:(NSString *)fileName {
	NSLog(@"%s", __FUNCTION__);
    
    // コンテンツの作成
    NSString *boundary = @"_insert_some_boundary_here_";
	NSMutableData* result = [[NSMutableData alloc] init];
	[result appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSASCIIStringEncoding]];
    [result appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"status\"\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
    [result appendData:[[NSString stringWithFormat:@"%@",post] dataUsingEncoding:NSASCIIStringEncoding]];
	[result appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
    
	[result appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSASCIIStringEncoding]];
    [result appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo\"; filename=\"%@\"\r\n", fileName] dataUsingEncoding:NSASCIIStringEncoding]];
    [result appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
    [result appendData:photo];
	[result appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
	[result appendData:[[NSString stringWithFormat:@"--%@--\r\n\r\n", boundary] dataUsingEncoding:NSASCIIStringEncoding]];
    
    // リクエストの作成
	NSURL *url = [NSURL URLWithString:@"http://api.mixi-platform.com/2/voice/statuses/update"];
    NSString *header = [[NSString alloc] initWithFormat:@"OAuth %@", [consumer getToken]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:header forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:result];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
    
	NSURLResponse *response = nil;
    NSError       *error    = nil;
	
    NSData *xoauth_response = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	[[[NSString alloc] initWithData:xoauth_response encoding:NSUTF8StringEncoding] autorelease];
	//NSString *str = [[[NSString alloc] initWithData:xoauth_response encoding:NSUTF8StringEncoding] autorelease];
    //NSLog(@"result:%@", str);
	//NSDictionary *ret = [str JSONValue];
}

-(void)postVoiceWithPhoto:(NSString *)post photo:(NSString *)photo {
    [self postVoiceWithPhotoData:post photo:[NSData dataWithContentsOfFile:photo] fileName:photo];
}

@end
