//
//  VRNavigationBar.m
//  scroll
//
//  Created by Viktor Radchenko on 3/30/14.
//  Copyright (c) 2014 SIX DAYS LLC. All rights reserved.
//

#import "VRNavigationBar.h"

#define offsetTop 20

@implementation VRNavigationBar

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(!_visible)
        return;
    
    CGRect frame = self.navigationController.navigationBar.frame;
    CGFloat size = frame.size.height - offsetTop;
    CGFloat framePercentageHidden = ((offsetTop - frame.origin.y) / (frame.size.height - 1));
    CGFloat scrollOffset = scrollView.contentOffset.y;
    CGFloat scrollDiff = scrollOffset - self.previousScrollViewYOffset;
    CGFloat scrollHeight = scrollView.frame.size.height;
    CGFloat scrollContentSizeHeight = scrollView.contentSize.height + scrollView.contentInset.bottom;
    
    if (scrollOffset <= -scrollView.contentInset.top) {
        frame.origin.y = offsetTop;
    } else if ((scrollOffset + scrollHeight) >= scrollContentSizeHeight) {
        frame.origin.y = -size;
    } else {
        frame.origin.y = MIN(offsetTop, MAX(-size, frame.origin.y - scrollDiff));
    }
    
    [self.navigationController.navigationBar setFrame:frame];
    [self updateBarButtonItems:(1 - framePercentageHidden)];
    self.previousScrollViewYOffset = scrollOffset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(!_visible)
        return;
    [self stoppedScrolling];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate) {
        [self stoppedScrolling];
    }
}

- (void)stoppedScrolling
{
    CGRect frame = self.navigationController.navigationBar.frame;
    if (frame.origin.y < offsetTop) {
        [self animateNavBarTo:-(frame.size.height - offsetTop)];
    }
}

- (void)updateBarButtonItems:(CGFloat)alpha
{
    [self.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
        item.customView.alpha = alpha;
    }];
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
        item.customView.alpha = alpha;
    }];
    self.navigationItem.titleView.alpha = alpha;
    self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:alpha];
}

- (void)animateNavBarTo:(CGFloat)y{
    if(!_visible){
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.navigationController.navigationBar.frame;
            CGFloat alpha = (frame.origin.y >= y ? 0 : 1);
            frame.origin.y = y;
            [self.navigationController.navigationBar setFrame:frame];
            [self updateBarButtonItems:alpha];
        }];
    }
}

-(void)showNavigationBar{
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.navigationController.navigationBar.frame;
        CGFloat alpha = 1;
        frame.origin.y = 20;
        [self.navigationController.navigationBar setFrame:frame];
        [self updateBarButtonItems:alpha];
    }];
}

-(void)hideNagigationBar{
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.navigationController.navigationBar.frame;
        CGFloat alpha = 0;
        frame.origin.y = 20 - self.navigationController.navigationBar.frame.size.height;
        [self.navigationController.navigationBar setFrame:frame];
        [self updateBarButtonItems:alpha];
    }];
}

@end
