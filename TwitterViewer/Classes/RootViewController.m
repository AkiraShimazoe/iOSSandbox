//
//  RootViewController.m
//  TwitterViewer
//
//  Created by 中村 薫 on 10/12/21.
//  Copyright 2010 personal. All rights reserved.
//

#import "RootViewController.h"
#import "URLLoader.h"
#import "StatusXMLParser.h"


@implementation RootViewController

@synthesize statuses;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	NSLog( @"viewDidLoad" );
	// ナビゲーションバーの色を青っぽく変更
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.3 green:0.6 blue:0.7 alpha:1.0];
	
	// 更新ボタンを追加
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
																						  target:self
																						  action:@selector(reload:)];

	[self loadTimelineByUserName:@"kaorun55"];
}

- (void) reload:(id)sender {
	[self loadTimelineByUserName:@"kaorun55"];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// (14)
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog( @"numberOfRowsInSection:%d", [self.statuses count] );
    return [self.statuses count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//NSLog( @"cellForRowAtIndexPath" );
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	int row = [indexPath row];
	
	NSString *name = [[statuses objectAtIndex:row] objectForKey:@"name"];
	NSString *text = [[statuses objectAtIndex:row] objectForKey:@"text"];
	
	// ユーザー名
	cell.textLabel.font = [UIFont systemFontOfSize:16];
	cell.textLabel.textColor = [UIColor lightGrayColor];
	cell.textLabel.text = name;
	
	// テキスト
	cell.detailTextLabel.numberOfLines = 0;
	cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
	cell.detailTextLabel.text = text;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
	
	CGSize bounds = CGSizeMake(self.tableView.frame.size.width - 150, self.tableView.frame.size.height);
	
	CGSize size = [cell.detailTextLabel.text sizeWithFont:cell.detailTextLabel.font
										  constrainedToSize:bounds
											lineBreakMode:UILineBreakModeCharacterWrap];
    return size.height;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


	 // (6)
	 - (void) loadTimelineByUserName:(NSString *)userName {
		 NSLog( @"loadTimelineByUserName" );
		 static NSString *urlFormat = @"http://twitter.com/status/user_timeline/%@.xml";
		 
		 NSString *url = [NSString stringWithFormat:urlFormat, userName];
		 URLLoader *loader = [[[URLLoader alloc] init] autorelease];
		 
		 [[NSNotificationCenter defaultCenter] addObserver:self
												  selector:@selector(loadTimelineDidEnd:) name:@"connectionDidFinishNotification" object:loader];
		 
		 [[NSNotificationCenter defaultCenter] addObserver:self
												  selector:@selector(loadTimelineFailed:) name:@"connectionDidFailedWithError" object:loader];
		 
		 [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		 
		 [loader loadFromUrl:url method:@"GET"];
	 }
	 
	 // (7)
	- (void) loadTimelineDidEnd: (NSNotification *)notification {
		NSLog( @"loadTimelineDidEnd" );
		 URLLoader *loader = (URLLoader *)[notification object];
		 NSData *xml = loader.data;
		 
		//NSLog( @"%@", [[NSString alloc] initWithData:xml encoding:NSUTF8StringEncoding] );
		StatusXMLParser *parser = [[[StatusXMLParser alloc] init] autorelease];
		self.statuses = [parser parseStatuses:xml];
		[self.tableView reloadData];
	 }
	 
	 // (8)
	- (void) loadTimelineFaied: (NSNotification *) notification {
		NSLog( @"loadTimelineFaied" );
		 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"タイムラインの取得に失敗しました"
														delegate:self cancelButtonTitle:@"閉じる" otherButtonTitles:nil];
		 
		 [alert show];
		 [alert release];
	 }

@end

