//
//  IGTBeerView.m
//  WeNeed
//
//  Created by Benjamin Wu on 11/8/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "IGTBeerView.h"

static CGFloat const kWaveLength = 320.0;
static CGFloat const kWaveAmplitude = 40.0;

@interface IGTBeerView ()

@property (strong, nonatomic) UIView *foamView;
@property (strong, nonatomic) CAShapeLayer *waveMask;

@end

@implementation IGTBeerView

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
    [self setUpBackground];
    [self setUpFoam];
    [self addLogo:[UIImage imageNamed:@"beer"] title:@"BEER"];
}

- (void)setUpBackground {
    [self addBackgroundWithColor:[UIColor colorWithRed:1 green:183.0/255.0 blue:0 alpha:1]];
    self.backgroundView.layer.mask = self.waveMask;
}

- (void)setUpFoam {
    self.foamView = [[UIView alloc] initWithFrame:self.bounds];
    self.foamView.backgroundColor = [UIColor colorWithRed:1 green:183.0/255.0 blue:0 alpha:1];

    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.foamView.bounds;
    gradient.colors = @[(id)[UIColor whiteColor].CGColor, (id)[[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor];
    gradient.startPoint = CGPointMake(.5, 0);
    gradient.endPoint = CGPointMake(.5, .2);
    [self.foamView.layer addSublayer:gradient];

    [self insertSubview:self.foamView belowSubview:self.backgroundView];
}

- (CAShapeLayer *)waveMask {
    if (!_waveMask) {
        _waveMask = [[CAShapeLayer alloc] init];

        CGMutablePathRef wave = CGPathCreateMutable();
        CGFloat x = 0.0;
        CGFloat y = 110.0;
        CGPathMoveToPoint(wave, nil, x, y);
        for (int i = 0; i < 15; i++) {
            CGPathAddCurveToPoint(wave, nil,
                                  x + kWaveLength / 2.0 , y - kWaveAmplitude + (arc4random() % (int) 20) - 10,
                                  x + kWaveLength / 2.0 , y + kWaveAmplitude + (arc4random() % (int) 20) - 10,
                                  x + kWaveLength, y);
            x += kWaveLength;
        }
        CGPathAddLineToPoint(wave, nil, x, 2000);
        CGPathAddLineToPoint(wave, nil, 0.0, 2000);
        CGPathAddLineToPoint(wave, nil, 0.0, 150.0);

        _waveMask.path = wave;
    }
    return _waveMask;
}

- (void)beginAnimation {
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.duration = 15.0;
    animation.keyPath = @"position.x";
    animation.toValue = @(-kWaveLength * 6);
    animation.removedOnCompletion = NO;
    animation.repeatCount = FLT_MAX;
    [self.waveMask addAnimation:animation forKey:@"sliding"];

    NSTimeInterval delay = 1.0;
    for (int i = 0; i < 100; i++) {
        [self performSelector:@selector(createAndAnimateBubble) withObject:nil afterDelay:delay];
        delay += .5;
    }
}

- (void)stopAnimation {
    [self.waveMask removeAnimationForKey:@"sliding"];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(createAndAnimateBubble) object:nil];
}

- (void)dealloc {
    [self stopAnimation];
}

- (void)createAndAnimateBubble {
    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bubble"]];

    // rand size
    CGFloat bubbleSize = 20 + arc4random() % 50;
    // rand origin
    CGFloat origin = arc4random() % (int)(self.frame.size.width - bubbleSize);
    bubbleImageView.frame = CGRectMake(origin, self.frame.size.height,
                                       bubbleSize, bubbleSize);

    [self.backgroundView addSubview:bubbleImageView];

    CGRect topFrame = CGRectMake(bubbleImageView.frame.origin.x, -bubbleImageView.frame.size.height,
                                 bubbleImageView.frame.size.width, bubbleImageView.frame.size.height);

    // rand duration
    [UIView animateWithDuration:3.0 + arc4random() % 5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         bubbleImageView.frame = topFrame;
                     } completion:^(BOOL finished) {
                         [bubbleImageView removeFromSuperview];
                     }];

}

@end
