//
//  AppDelegate.h
//  Finder
//
//  Created by Benno Krauss on 05.09.12.
//  Copyright (c) 2012 Benno Krauss. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilesTableViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FilesTableViewController *viewController;

@end
