//
//  IGTWeedView.m
//  WeNeed
//
//  Created by David Zheng on 11/9/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "IGTTreesView.h"

@implementation IGTTreesView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.clipsToBounds = YES;
    [self addBackgroundWithColor:[UIColor colorWithRed:45.0/255.0 green:207.0/255.0 blue:99.0/255.0 alpha:1]];
    [self addLogo:[UIImage imageNamed:@"trees"] title:@"TREES"];
    [self setupLeafPile];
    [self setupFallingLeaves];

}

-(void)setupFallingLeaves{
    NSTimeInterval delay = 1.0;
    for (int i = 0; i < 100; i++) {
        [self performSelector:@selector(createAndAnimateLeaves) withObject:nil afterDelay:delay];
        delay += 1.5;
    }
}

-(void)setupLeafPile{
//    NSString *leafPileName = @"leaf-pile-1";
    UIImageView *leafPileView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leaf-pile-1"]];
    leafPileView.frame = CGRectMake(-60, self.frame.size.height - 172, self.frame.size.width+120, 172);
    [self.backgroundView addSubview:leafPileView];
}

-(void)animateLeafPile{
    
}

- (void)createAndAnimateLeaves {
    NSString *leafImageName = (arc4random()%2)?@"leaf-stem-left":@"leaf-stem-right";
    UIImageView *leafView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leafImageName]];
    
    // rand size
    CGFloat leafSize = 30 + arc4random() % 20;
    // rand origin
    CGFloat origin = arc4random() % (int)(self.frame.size.width - leafSize);
    leafView.frame = CGRectMake(origin, 20,
                                       leafSize, leafSize);
    
    [self.backgroundView addSubview:leafView];
    
    CGRect bottomFrame = CGRectMake(leafView.frame.origin.x, self.frame.size.height - leafSize - 20,
                                 leafView.frame.size.width, leafView.frame.size.height);
    
    // rand duration
    [UIView animateWithDuration:3.0 + arc4random() % 5
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         leafView.frame = bottomFrame;
                     } completion:^(BOOL finished) {
                         [leafView removeFromSuperview];
                     }];
    
}

@end
