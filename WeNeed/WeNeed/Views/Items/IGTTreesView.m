//
//  IGTWeedView.m
//  WeNeed
//
//  Created by David Zheng on 11/9/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "IGTTreesView.h"

@interface IGTTreesView()

@property (nonatomic, strong) UIImageView *leafPileView;

@end

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
    self.leafPileView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leaf-pile-1"]];
    self.leafPileView.frame = CGRectMake(-60, self.frame.size.height - 172, self.frame.size.width+120, 172);
    [self.backgroundView addSubview:self.leafPileView];
    
    [self startLeafPileCycle];
}

-(void)startLeafPileCycle{
    NSTimeInterval delay = 15.0;
    for (int i = 2; i <= 4; i++) {
        [self performSelector:@selector(transitionLeavesToState:) withObject:@(i) afterDelay:delay];
        delay += 15.0;
    }
}

-(void)transitionLeavesToState:(NSNumber*)state{
    NSString *leafPileImage = [NSString stringWithFormat:@"leaf-pile-%i", [state intValue]];
    UIImageView *tempLeafPile = [[UIImageView alloc] initWithImage:self.leafPileView.image];
    tempLeafPile.frame = self.leafPileView.frame;
    [self.backgroundView addSubview:tempLeafPile];
    
    self.leafPileView.alpha = 0.0;
    self.leafPileView.image = [UIImage imageNamed:leafPileImage];
    
    [UIView animateWithDuration:2.0 animations:^{
        self.leafPileView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [tempLeafPile removeFromSuperview];
    }];
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
                         [UIView animateWithDuration:1.0
                                               delay:2.0
                                             options:0
                                          animations:^{
                                              leafView.alpha = 0.0;
                                            }
                                          completion:^(BOOL finished) {
                             [leafView removeFromSuperview];
                         }];
                         
                     }];
    
}

- (void)stopAnimation{
    
}

@end
