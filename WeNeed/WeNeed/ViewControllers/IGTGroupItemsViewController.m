//
//  GroupItemsViewController.m
//  WeNeed
//
//  Created by David Zheng on 11/8/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "IGTGroupItemsViewController.h"

@interface IGTGroupItemsViewController ()

@property (nonatomic, strong) UICollectionView *itemsCollectionView;
@property (nonatomic, strong) NSArray *itemsData;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *iGotThisButton;

@end

@implementation IGTGroupItemsViewController

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
    pageControlFrame.origin.y = pageControlFrame.size.height - 60;
    pageControlFrame.size.height = 60;
    self.pageControl = [[UIPageControl alloc] initWithFrame:pageControlFrame];
    self.pageControl.numberOfPages = self.itemsData.count;

    [self.pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];

    self.iGotThisButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iGotThisButton.frame = CGRectMake(25, pageControlFrame.origin.y - 15 - 50, self.view.frame.size.width - 25 - 25, 50);
    self.iGotThisButton.layer.cornerRadius = 5;
    self.iGotThisButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.iGotThisButton.layer.shadowOffset = CGSizeMake(0, 2);
    self.iGotThisButton.layer.shadowRadius = 2;
    self.iGotThisButton.layer.shadowOpacity = .5;
    [self.iGotThisButton setBackgroundImage:[UIColor imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.iGotThisButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.iGotThisButton setTitle:@"I Got This" forState:UIControlStateNormal];
    [self.iGotThisButton addTarget:self action:@selector(iGotThisButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.iGotThisButton];
}

#pragma mark - UICollectionViewDataSource methods

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
            [cell setBackgroundColor:[UIColor yellowColor]];
            break;
        case 1:
            [cell setBackgroundColor:[UIColor greenColor]];
            break;
        case 2:
            [cell setBackgroundColor:[UIColor blackColor]];
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - Page Control

- (void)pageControlChanged:(id)sender
{
    UIPageControl *pageControl = sender;
    CGFloat pageWidth = self.itemsCollectionView.frame.size.width;
    CGPoint scrollTo = CGPointMake(pageWidth * pageControl.currentPage, 0);
    [self.itemsCollectionView setContentOffset:scrollTo animated:YES];
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.itemsCollectionView.frame.size.width;
    self.pageControl.currentPage = self.itemsCollectionView.contentOffset.x / pageWidth;
}

#pragma mark - Actions

- (void)iGotThisButtonPressed:(UIButton *)button {

}

@end
