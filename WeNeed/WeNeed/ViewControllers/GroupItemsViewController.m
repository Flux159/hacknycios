//
//  GroupItemsViewController.m
//  WeNeed
//
//  Created by David Zheng on 11/8/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "GroupItemsViewController.h"

@interface GroupItemsViewController ()

@property (nonatomic, strong) UICollectionView *itemsCollectionView;
@property (nonatomic, strong) NSArray *itemsData;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation GroupItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:self.view.frame.size];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0];
    [flowLayout setMinimumLineSpacing:0];
    [flowLayout setSectionInset:UIEdgeInsetsZero];
    [flowLayout setItemSize:self.view.frame.size];
    
    self.itemsData = @[@"beer", @"pizza", @"trees"];
    
    self.itemsCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    [self.itemsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ReuseCell"];
    [self.itemsCollectionView setDataSource:self];
    [self.itemsCollectionView setDelegate:self];
    [self.itemsCollectionView setPagingEnabled:YES];
    [self.view addSubview:self.itemsCollectionView];
    
    CGRect pageControlFrame = self.view.frame;
    pageControlFrame.origin.y = pageControlFrame.size.height - 90;
    pageControlFrame.size.height = 60;
    self.pageControl = [[UIPageControl alloc] initWithFrame:pageControlFrame];
    self.pageControl.numberOfPages = self.itemsData.count;
    
    [self.pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemsData.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self.itemsCollectionView dequeueReusableCellWithReuseIdentifier:@"ReuseCell" forIndexPath:indexPath];
    NSUInteger number = indexPath.row;
    switch (number) {
        case 0:
            [cell setBackgroundColor:[UIColor redColor]];
            break;
        case 1:
            [cell setBackgroundColor:[UIColor blueColor]];
            break;
        case 2:
            [cell setBackgroundColor:[UIColor blackColor]];
            break;
        default:
            break;
    }
    return cell;
}

- (void)pageControlChanged:(id)sender
{
    UIPageControl *pageControl = sender;
    CGFloat pageWidth = self.itemsCollectionView.frame.size.width;
    CGPoint scrollTo = CGPointMake(pageWidth * pageControl.currentPage, 0);
    [self.itemsCollectionView setContentOffset:scrollTo animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.itemsCollectionView.frame.size.width;
    self.pageControl.currentPage = self.itemsCollectionView.contentOffset.x / pageWidth;
}

@end
