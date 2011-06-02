#import <Foundation/Foundation.h>
#import "Mixi.h"
#import "MixiOAuthKey.h"

int main (int argc, const char * argv[]) {
    NSLog(@"%s", argv[0]);
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	Mixi *mixi = [[Mixi alloc] init:CONSUMER_KEY consumerSecret:CONSUMER_SECRET];

    [mixi setAccessToken:@"e475ace909078ac01087cdd472307a17f5073cd6"];

#if 0
	// Aauthorize request URLの作成
	NSString *urlString = [mixi getAauthorizeRequestURL:@"r_profile w_voice"];
	NSLog(@"Aauthorize request in this page :%@", urlString);
	NSLog(@"Please input redirest url's 'code' parameter :");
	
	char code[128] = "";
	scanf("%s", code);

	// Access Tokenの取得
	NSString *accessToken = [mixi getAccessToken:[[NSString alloc] initWithCString:code] redirectURI:@"http://example.com/callback"];
	NSLog(@"Access Token:%@", accessToken);
#endif

	// プロフィールの取得
	NSDictionary *dict = [mixi getPeople];
	for ( NSString *key in [dict keyEnumerator] ) {
		NSLog(@"key:%@, value:%@", key, [dict objectForKey:key]);
	}

//	[mixi postVoice:@"from objective-c post"];
	[mixi postVoiceWithPhoto:@"from application post" photo:@"sample.jpg"];
	
    // insert code here...
    NSLog(@"Hello, World!");
    [pool drain];
    return 0;
}
