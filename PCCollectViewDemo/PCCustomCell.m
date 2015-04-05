//
//  PCCustomCell.m
//  PCCollectViewDemo
//
//  Created by 张培创 on 15/4/2.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import "PCCustomCell.h"

@implementation PCCustomCell

- (void)awakeFromNib
{
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.imageView addGestureRecognizer:tap];
}

- (void)tapAction
{
    NSLog(@"cell : %@", NSStringFromCGRect(self.frame));
}

@end
