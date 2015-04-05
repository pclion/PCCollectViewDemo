//
//  ViewController.m
//  PCCollectViewDemo
//
//  Created by 张培创 on 15/4/2.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import "ViewController.h"
#import "PCFlowLayout.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet PCFlowLayout *flowLayout;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.collectView.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray array];
    
    //test
    for (int i = 0; i < 30; i++) {
        NSInteger height = arc4random() % 200;
        if (height < 100) {
            height = 100;
        }
        [self.dataArray addObject:@(height)];
    }
    self.flowLayout.itemHeightArray = [self.dataArray copy];
    self.flowLayout.headerViewHeight = 100;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *resueView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"reuseView" forIndexPath:indexPath];
    return resueView;
}

@end
