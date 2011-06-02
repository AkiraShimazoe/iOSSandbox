//
//  XMLParserTest.m
//  TwitterViewer
//
//  Created by 中村 薫 on 10/12/22.
//  Copyright 2010 personal. All rights reserved.
//

#import "XMLParserTest.h"
#import "StatusXMLParser.h"

NSString *xml = @"<statuses>"
"<status>"
"<created_at>Tue Dec 21 15:28:02 +0000 2010</created_at>"
"<id>17239881432436736</id>"
"<text>@amapyon &#12362;&#12417;&#12391;&#12392;&#12358;&#12372;&#12374;&#12356;&#12414;&#12377;&#65281;</text>"
"<source>&lt;a href=&quot;http://www.echofon.com/&quot; rel=&quot;nofollow&quot;&gt;Echofon&lt;/a&gt;</source>"
"<truncated>false</truncated>"
"<favorited>false</favorited>"
"<in_reply_to_status_id>17233911864098817</in_reply_to_status_id>"
"<in_reply_to_user_id>4336241</in_reply_to_user_id>"
"<in_reply_to_screen_name>amapyon</in_reply_to_screen_name>"
"<retweet_count>0</retweet_count>"
"<retweeted>false</retweeted>"
"<user>"
"<id>5855952</id>"
"<name>&#12394;&#12363;&#12416;&#12425;&#12288;&#12363;&#12362;&#12427;</name>"
"<screen_name>kaorun55</screen_name>"
"<location>&#26481;&#20140;&#12398;&#12399;&#12376;&#12387;&#12371;</location>"
"<description>B&#22411;&#12506;&#12540;&#12497;&#12540;&#35469;&#23450;&#12473;&#12463;&#12521;&#12512;&#12510;&#12473;&#12479;&#12540;"
"&#65286;"
"&#12503;&#12525;&#12398;&#12464;&#12521;&#12510;&#12540;</description>"
"<profile_image_url>http://a2.twimg.com/profile_images/595941490/kaorun55_96x96_normal.jpg</profile_image_url>"
"<url>http://d.hatena.ne.jp/kaorun55/</url>"
"<protected>false</protected>"
"<followers_count>775</followers_count>"
"<profile_background_color>EBEBEB</profile_background_color>"
"<profile_text_color>333333</profile_text_color>"
"<profile_link_color>990000</profile_link_color>"
"<profile_sidebar_fill_color>F3F3F3</profile_sidebar_fill_color>"
"<profile_sidebar_border_color>DFDFDF</profile_sidebar_border_color>"
"<friends_count>444</friends_count>"
"<created_at>Tue May 08 07:22:11 +0000 2007</created_at>"
"<favourites_count>171</favourites_count>"
"<utc_offset>32400</utc_offset>"
"<time_zone>Tokyo</time_zone>"
"<profile_background_image_url>http://s.twimg.com/a/1292022067/images/themes/theme7/bg.gif</profile_background_image_url>"
"<profile_background_tile>false</profile_background_tile>"
"<profile_use_background_image>true</profile_use_background_image>"
"<notifications></notifications>"
"<geo_enabled>false</geo_enabled>"
"<verified>false</verified>"
"<following></following>"
"<statuses_count>11272</statuses_count>"
"<lang>ja</lang>"
"<contributors_enabled>false</contributors_enabled>"
"<follow_request_sent></follow_request_sent>"
"<listed_count>120</listed_count>"
"<show_all_inline_media>false</show_all_inline_media>"
"<is_translator>false</is_translator>"
"</user>"
"<geo/>"
"<coordinates/>"
"<place/>"
"<contributors/>"
"</status>"
"</statuses>";


@implementation XMLParserTest

- (void) testXMLParse {
	StatusXMLParser *parser = [[[StatusXMLParser alloc] init] autorelease];
	NSData *xmlData = [[[NSData alloc] initWithContentsOfFile:@"data.xml"] autorelease];
	NSArray *statuses = [parser parseStatuses:xmlData];
	
    STAssertEquals(@"kaorun", [[statuses objectAtIndex:0] objectForKey:@"name"], @"ユーザー名が一致" );
}

@end
