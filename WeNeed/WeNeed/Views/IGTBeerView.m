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

@property (strong, nonatomic) UIImageView *beerImageView;
@property (strong, nonatomic) CAShapeLayer *waveMask;
@property (strong, nonatomic) CALayer *tintLayer;

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
    self.beerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beer"]];
    self.beerImageView.center = CGPointMake(self.center.x, self.center.y - 75.0);
    [self addSubview:self.beerImageView];

    CAShapeLayer *beerBorder = [[CAShapeLayer alloc] init];
    CGFloat borderRadius = 90.0;
    CGRect borderFrame = CGRectMake(self.beerImageView.center.x - borderRadius,
                                    self.beerImageView.center.y - borderRadius,
                                    borderRadius * 2, borderRadius * 2);
    beerBorder.path = [UIBezierPath bezierPathWithOvalInRect:borderFrame].CGPath;
    beerBorder.strokeColor = [UIColor blackColor].CGColor;
    beerBorder.fillColor = [UIColor clearColor].CGColor;
    beerBorder.lineWidth = 7.5;
    [self.layer addSublayer:beerBorder];

    self.tintLayer = [[CALayer alloc] init];
    self.tintLayer.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:140.0/255.0 blue:25.0/255.0 alpha:0.7].CGColor;
    [self.layer addSublayer:self.tintLayer];
    self.layer.mask = self.waveMask;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tintLayer.frame = self.bounds;
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

    [self addSubview:bubbleImageView];

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
