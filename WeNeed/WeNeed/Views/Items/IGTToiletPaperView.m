//
//  IGTToiletPaperView.m
//  WeNeed
//
//  Created by Benjamin Wu on 11/9/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "IGTToiletPaperView.h"

static CGFloat const kSheetWidth = 250.0;
static CGFloat const kNumberOfSheets = 10;

@interface IGTToiletPaperView ()

@property (strong, nonatomic) UIView *toiletPaperRoll;

@end

@implementation IGTToiletPaperView

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
    [self addBackgroundWithColor:[UIColor colorWithRed:88.0/255.0 green:201.0/255.0 blue:253.0/255.0 alpha:1]];
    [self addLogo:[UIImage imageNamed:@"toilet-paper"] title:@"TOILET PAPER"];
    [self setUpRoll];
}

- (void)setUpRoll {
    self.toiletPaperRoll = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - kSheetWidth) / 2, -kSheetWidth * kNumberOfSheets, kSheetWidth, kSheetWidth * kNumberOfSheets)];
    for (int i = 0; i < kNumberOfSheets; i++) {
        UIImageView *sheet = [[UIImageView alloc] initWithFrame:CGRectMake(0, kSheetWidth * i, kSheetWidth, kSheetWidth)];
        [sheet setImage:[UIImage imageNamed:@"tp-bg"]];
        [self.toiletPaperRoll addSubview:sheet];
    }
    [self.backgroundView addSubview:self.toiletPaperRoll];
}

- (void)beginAnimation {
    NSTimeInterval secondsPerSheet = 2.0;
    CGRect newFrame = self.toiletPaperRoll.frame;
    newFrame.origin.y = -kSheetWidth * kNumberOfSheets; // Reset the view
    self.toiletPaperRoll.frame = newFrame;

    newFrame.origin.y = newFrame.origin.y + kSheetWidth * 3;

    [UIView animateWithDuration:secondsPerSheet * 3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.toiletPaperRoll.frame = newFrame;
    } completion:^(BOOL finished) {
        CABasicAnimation *basicAnimation = [[CABasicAnimation alloc] init];
        basicAnimation.keyPath = @"position.y";
        basicAnimation.byValue = @(kSheetWidth);
        basicAnimation.duration = secondsPerSheet;
        basicAnimation.repeatCount = FLT_MAX;
        basicAnimation.removedOnCompletion = NO;
        [self.toiletPaperRoll.layer addAnimation:basicAnimation forKey:@"sheetAnimation"];
    }];
}

- (void)stopAnimation {
    // Not properly canceling if we scroll off tp and back before the initial animation block.
    [self.toiletPaperRoll.layer removeAllAnimations];
}

@end
