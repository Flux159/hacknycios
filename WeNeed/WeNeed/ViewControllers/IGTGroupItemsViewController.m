//
//  GroupItemsViewController.m
//  WeNeed
//
//  Created by David Zheng on 11/8/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "IGTGroupItemsViewController.h"

#import "IGTBeerView.h"
#import "IGTToiletPaperView.h"

@interface IGTGroupItemsViewController ()

@property (nonatomic, strong) UICollectionView *itemsCollectionView;
@property (nonatomic, strong) NSArray *itemsData;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *iGotThisButton;

@property (nonatomic, strong) IGTBeerView *beerView;
@property (nonatomic, strong) IGTToiletPaperView *toiletPaperView;

@end

@implementation IGTGroupItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpViews];
}

- (void)setUpViews {
    [self setUpCollectionView];
    [self setUpPageControl];
    [self setUpIGotThisButton];
}

- (void)setUpCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:self.view.frame.size];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0];
    [flowLayout setMinimumLineSpacing:0];
    [flowLayout setSectionInset:UIEdgeInsetsZero];
    [flowLayout setItemSize:self.view.frame.size];


    self.itemsCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.itemsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ReuseCell"];
    [self.itemsCollectionView setDataSource:self];
    [self.itemsCollectionView setDelegate:self];
    [self.itemsCollectionView setPagingEnabled:YES];
    [self.view addSubview:self.itemsCollectionView];

    [self setUpPages];
}

- (void)setUpPages {
    self.itemsData = @[@"beer", @"pizza", @"trees"];
    self.beerView = [[IGTBeerView alloc] initWithFrame:self.view.bounds];
    self.toiletPaperView = [[IGTToiletPaperView alloc] initWithFrame:self.view.bounds];
}

- (void)setUpPageControl {
    CGRect pageControlFrame = self.view.frame;
    pageControlFrame.origin.y = pageControlFrame.size.height - 60;
    pageControlFrame.size.height = 60;
    self.pageControl = [[UIPageControl alloc] initWithFrame:pageControlFrame];
    self.pageControl.numberOfPages = self.itemsData.count;

    [self.pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];
}

- (void)setUpIGotThisButton {
    self.iGotThisButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iGotThisButton.frame = CGRectMake(25, self.pageControl.frame.origin.y - 15 - 50, self.view.frame.size.width - 25 - 25, 50);
    self.iGotThisButton.layer.cornerRadius = 5;
    self.iGotThisButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.iGotThisButton.layer.shadowOffset = CGSizeMake(0, 2);
    self.iGotThisButton.layer.shadowRadius = 2;
    self.iGotThisButton.layer.shadowOpacity = .5;
    [self.iGotThisButton setBackgroundImage:[UIColor imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.iGotThisButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.iGotThisButton setTitle:@"WE NEED THIS" forState:UIControlStateNormal];
    self.iGotThisButton.titleLabel.font = [UIFont igtMediumFontWithSize:IGTFontSizeBody];

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
    NSUInteger number = indexPath.item;
    cell.backgroundColor = [UIColor whiteColor];
    // TODO: This is really the wrong way to handle the cells.
    switch (number) {
        case 0:
            [self.beerView removeFromSuperview];
//            [self.beerView beginAnimation];
            [cell addSubview:self.beerView];
            break;
        case 1:
            break;
        case 2:
            [self.toiletPaperView removeFromSuperview];
            [self.toiletPaperView beginAnimation];
            [cell addSubview:self.toiletPaperView];
            break;
        default:
            break;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.item) {
        case 0:
            [self.beerView stopAnimation];
            break;
        case 1:
            break;
        case 2:
            [self.toiletPaperView stopAnimation];
        default:
            break;
    }

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
