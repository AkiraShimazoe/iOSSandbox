#import <Foundation/Foundation.h>
#import "OAuthCore.h"
#import "OAuth+Additions.h"
#import "CacooOAuthKey.h"

// アクセストークン
#define ACCESS_TOKEN @"https://cacoo.com/oauth/access_token"
#define AUTHORIZE @"https://cacoo.com/oauth/authorize"
#define REQUEST_TOKEN @"https://cacoo.com/oauth/request_token"

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


@interface Cacoo : NSObject
+(NSString *)request:(NSString *)uri consumer:(OAuthConsumer *)consumer method:(NSString *)method body:(NSString *)_body;
+(NSString *)receiveRequestToken:(OAuthConsumer *)consumer;
+(void)receiveAccessToken:(OAuthConsumer *)consumer pin:(NSString *)pin;
+(NSString *)receiveRequest:(NSString *)uri consumer:(OAuthConsumer *)consumer;
@end

@implementation Cacoo

+(NSString *)request:(NSString *)uri consumer:(OAuthConsumer *)consumer method:(NSString *)method body:(NSString *)_body {
	NSURL *url = [NSURL URLWithString:uri];
	NSData *body = [[NSString stringWithString:_body] dataUsingEncoding:NSUTF8StringEncoding];
	NSString *header = OAuthorizationHeader(url, method, body, [consumer getConsumerKey], [consumer getConsumerSecret], [consumer getToken], [consumer getTokenSecret]);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:method];
    [request setValue:header forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:body];
    
	NSURLResponse *response = nil;
    NSError       *error    = nil;
	
    NSData *xauth_response = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString *result = [[[NSString alloc] initWithData:xauth_response encoding:NSUTF8StringEncoding] autorelease];
	
	return result;
}

+(NSString *)receiveRequestToken:(OAuthConsumer *)consumer {
	NSLog(@"%s", __FUNCTION__ );

	NSString *result = [self request:REQUEST_TOKEN consumer:consumer method:@"GET" body:@""];
    NSDictionary *dict = [NSURL ab_parseURLQueryString:result];	
	[consumer setAccessToken:[dict objectForKey:@"oauth_token"] tokenSecret:[dict objectForKey:@"oauth_token_secret"]];
	return [[[NSString alloc] initWithFormat:@"%@?%@", AUTHORIZE, result] autorelease];
}

+(void)receiveAccessToken:(OAuthConsumer *)consumer pin:(NSString *)pin {
	NSLog(@"%s", __FUNCTION__ );
	
	NSString *result = [self request:ACCESS_TOKEN consumer:consumer method:@"POST" body:[NSString stringWithFormat:@"oauth_verifier=%@", pin]];
    NSDictionary *dict = [NSURL ab_parseURLQueryString:result];		
	[consumer setAccessToken:[dict objectForKey:@"oauth_token"] tokenSecret:[dict objectForKey:@"oauth_token_secret"]];
}

+(NSString *)receiveRequest:(NSString *)uri consumer:(OAuthConsumer *)consumer {
	NSLog(@"%s", __FUNCTION__ );
	
	return [self request:uri consumer:consumer method:@"GET" body:@""];
}
@end



int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
    // insert code here...
    NSLog(@"Hello, World!");
	OAuthConsumer *consumer = [[OAuthConsumer alloc] init:CONSUMER_KEY consumerSecret:CONSUMER_KEY_SECRET];
	NSString *AuthorizeURL = [Cacoo receiveRequestToken:consumer];
	NSLog(@"AuthorizeURL:%@", AuthorizeURL );
	
	char PIN[32] = "";
	NSLog(@"PIN:" );
	scanf("%s", PIN);
	NSString *pin = [[NSString alloc]initWithCString:PIN];
	NSLog(@"PIN:%@", pin );
	
	[Cacoo receiveAccessToken:consumer pin:pin];
	NSString *result = [Cacoo receiveRequest:@"https://cacoo.com/api/v1/account.xml" consumer:consumer];
	NSLog(@"result:%@", result);
	
    [pool drain];
    return 0;
}
