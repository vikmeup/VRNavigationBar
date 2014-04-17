//
//  VRNavigationBar.h
//  scroll
//
//  Created by Viktor Radchenko on 3/30/14.
//  Copyright (c) 2014 SIX DAYS LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VRNavigationBar : UITableViewController

@property CGFloat previousOffset;
@property (getter = isVisble) BOOL visible;

- (void)showNavigationBar;
- (void)hideNagigationBar;

@end
