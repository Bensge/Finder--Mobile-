//
//  FileDetailsViewController.h
//  Finder
//
//  Created by Benno Krauss on 05.09.12.
//  Copyright (c) 2012 Benno Krauss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileDetailsViewController : UITableViewController
@property (strong) NSDictionary *details;
@property (strong) NSString *fileName;
@end
