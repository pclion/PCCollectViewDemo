//
//  PCFlowLayout.m
//  PCCollectViewDemo
//
//  Created by 张培创 on 15/4/2.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import "PCFlowLayout.h"

#define HorizontalSpacing   8
#define VeticalSpacing      10
#define CellSpacing         6
#define LineSpacing         10

@interface PCFlowLayout ()

@property (nonatomic, strong) NSArray *tempArray;//解决由于滚动时候系统返回的数组为空导致的底部空白问题

@end

@implementation PCFlowLayout

- (CGSize)collectionViewContentSize
{
    NSInteger height = 0;
    __block NSInteger leftHeight = VeticalSpacing;
    __block NSInteger rightHeight = VeticalSpacing;
    [self.itemHeightArray enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        if (idx % 2 == 0) {
            leftHeight += [obj integerValue] + LineSpacing;
        } else {
            rightHeight += [obj integerValue] + LineSpacing;
        }
    }];
    leftHeight = leftHeight - LineSpacing + VeticalSpacing;
    rightHeight = rightHeight - LineSpacing + VeticalSpacing;
    height = leftHeight > rightHeight ? leftHeight : rightHeight;
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), height + self.headerViewHeight);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.itemSize = CGSizeMake((CGRectGetWidth([UIScreen mainScreen].bounds) - HorizontalSpacing * 2 - CellSpacing) / 2, 0);
        self.headerReferenceSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 50);
        self.minimumInteritemSpacing = CellSpacing;
        self.minimumLineSpacing = LineSpacing;
        self.sectionInset = UIEdgeInsetsMake(VeticalSpacing, HorizontalSpacing, VeticalSpacing, HorizontalSpacing);
    }
    return self;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    if ([array count] == 0 && [self.itemHeightArray count] != 0) {
        //如果当前系统返回数组为0 且 存在数据源的情况下 使用之前保存数组
        array = self.tempArray;
    }
    [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL *stop) {
        if (attribute.representedElementKind == nil) {        //判断当前是否为collectioncell
            if ([self.itemHeightArray count] > idx) {
                //位置计算代码
                NSInteger height = [self.itemHeightArray[idx] integerValue];
                CGFloat y = 0;
                if (attribute.indexPath.row / 2 == 0) {
                    y = VeticalSpacing + self.headerViewHeight;
                } else {
                    UICollectionViewLayoutAttributes *previousAtt = array[attribute.indexPath.row - 2];
                    if (attribute.indexPath.row == [self.itemHeightArray count] - 1) {
                        y = CGRectGetMaxY(previousAtt.frame) + VeticalSpacing;
                    } else {
                        y = CGRectGetMaxY(previousAtt.frame) + LineSpacing;
                    }
                }
                CGRect rect = attribute.frame;
                rect.size.height = height;
                rect.origin.y = y;
                attribute.frame = rect;
            }
        } else if ([attribute.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            attribute.frame = CGRectMake(CGRectGetMinX(attribute.frame), 0, CGRectGetWidth(attribute.frame), self.headerViewHeight);
        }
        
    }];
    self.tempArray = array;
    return array;
}

//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return YES;
//}

@end
