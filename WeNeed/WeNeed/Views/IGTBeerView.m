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

@property (strong, nonatomic) UIView *backgroundBeerView;
@property (strong, nonatomic) UIView *foamView;
@property (strong, nonatomic) UIImageView *beerImageView;
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
    [self setUpBeerLogo];
}

- (void)setUpBackground {
    self.backgroundBeerView = [[UIView alloc] initWithFrame:self.bounds];

    self.backgroundBeerView.backgroundColor = [UIColor colorWithRed:1 green:183.0/255.0 blue:0 alpha:1];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.backgroundBeerView.bounds;
    gradient.colors = @[(id)[[UIColor whiteColor] colorWithAlphaComponent:0.15].CGColor, (id)[[UIColor blackColor] colorWithAlphaComponent:0.15].CGColor];
    gradient.startPoint = CGPointMake(.5, 0);
    gradient.endPoint = CGPointMake(.5, 1);
    [self.backgroundBeerView.layer addSublayer:gradient];

    CAGradientLayer *gradient2 = [CAGradientLayer layer];
    gradient2.frame = self.backgroundBeerView.bounds;
    gradient2.colors = gradient.colors = @[(id)[[UIColor whiteColor] colorWithAlphaComponent:0].CGColor, (id)[[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor];
    gradient2.startPoint = CGPointMake(0.5, 0.7);
    gradient2.endPoint = CGPointMake(0.5, 1);
    [self.backgroundBeerView.layer addSublayer:gradient2];

    [self addSubview:self.backgroundBeerView];

    self.backgroundBeerView.layer.mask = self.waveMask;
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

    [self insertSubview:self.foamView belowSubview:self.backgroundBeerView];
}

- (void)setUpBeerLogo {
    UIColor *beerLogoColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];

    self.beerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beer"]];
    self.beerImageView.center = CGPointMake(self.center.x, self.center.y - 75.0);
    self.beerImageView.alpha = 0.6;
    [self addSubview:self.beerImageView];

    CGFloat borderRadius = 90.0;
    CGRect borderFrame = CGRectMake(self.beerImageView.center.x - borderRadius,
                                    self.beerImageView.center.y - borderRadius,
                                    borderRadius * 2, borderRadius * 2);
    UIView *beerBorderView = [[UIView alloc] initWithFrame:borderFrame];
    beerBorderView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:180.0/255.0 blue:24.0/255.0 alpha:0.6];
    beerBorderView.layer.cornerRadius = borderFrame.size.width / 2.0;
    beerBorderView.layer.borderWidth = 7.5;
    beerBorderView.layer.borderColor = beerLogoColor.CGColor;

    [self insertSubview:beerBorderView belowSubview:self.beerImageView];

    UILabel *beerLabel = [[UILabel alloc] init];
    beerLabel.font = [UIFont igtDefaultBoldFont];
    beerLabel.textColor = beerLogoColor;
    beerLabel.attributedText = [[NSAttributedString alloc] initWithString:@"BEER"
                                                               attributes:@{NSKernAttributeName : @7}];
    [beerLabel sizeToFit];
    beerLabel.center = CGPointMake(self.frame.size.width / 2.0, CGRectGetMaxY(beerBorderView.frame) + 30);

    [self addSubview:beerLabel];
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

    [self.backgroundBeerView addSubview:bubbleImageView];

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
