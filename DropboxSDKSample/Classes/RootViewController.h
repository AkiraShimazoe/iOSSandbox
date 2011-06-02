//
//  RootViewController.h
//  DropboxSDKSample
//
//  Created by 中村 薫 on 11/01/05.
//  Copyright 2011 personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBRestClient.h"

@interface RootViewController : UITableViewController < DBRestClientDelegate > {
    DBRestClient *restClient;
}

@property(nonatomic,readonly) DBRestClient *restClient;

@end
