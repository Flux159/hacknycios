//
//  IGTItemView.m
//  WeNeed
//
//  Created by Benjamin Wu on 11/9/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "IGTItemView.h"

@implementation IGTItemView

- (void)addBackgroundWithColor:(UIColor *)color {
    self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];

    self.backgroundView.backgroundColor = color;

    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.backgroundView.bounds;
    gradient.colors = @[(id)[[UIColor whiteColor] colorWithAlphaComponent:0.15].CGColor, (id)[[UIColor blackColor] colorWithAlphaComponent:0.15].CGColor];
    gradient.startPoint = CGPointMake(.5, 0);
    gradient.endPoint = CGPointMake(.5, 1);
    [self.backgroundView.layer addSublayer:gradient];

    CAGradientLayer *gradient2 = [CAGradientLayer layer];
    gradient2.frame = self.backgroundView.bounds;
    gradient2.colors = gradient.colors = @[(id)[[UIColor whiteColor] colorWithAlphaComponent:0].CGColor, (id)[[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor];
    gradient2.startPoint = CGPointMake(0.5, 0.7);
    gradient2.endPoint = CGPointMake(0.5, 1);
    [self.backgroundView.layer addSublayer:gradient2];

    [self addSubview:self.backgroundView];
}

- (void)addLogo:(UIImage *)logo title:(NSString *)title {
    CGFloat alpha = 0.6;
    UIColor *logoColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];

    self.logoImageView = [[UIImageView alloc] initWithImage:logo];
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.logoImageView.frame = CGRectMake(0,0,100,100);
    self.logoImageView.center = CGPointMake(self.center.x, self.center.y - 75.0);
    self.logoImageView.alpha = alpha;
    [self addSubview:self.logoImageView];

    CGFloat borderRadius = 90.0;
    CGRect borderFrame = CGRectMake(self.logoImageView.center.x - borderRadius,
                                    self.logoImageView.center.y - borderRadius,
                                    borderRadius * 2, borderRadius * 2);
    UIView *logoBorderView = [[UIView alloc] initWithFrame:borderFrame];
    logoBorderView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:180.0/255.0 blue:24.0/255.0 alpha:0.6];
    logoBorderView.layer.cornerRadius = borderFrame.size.width / 2.0;
    logoBorderView.layer.borderWidth = 7.5;
    logoBorderView.layer.borderColor = logoColor.CGColor;
    [self insertSubview:logoBorderView belowSubview:self.logoImageView];

    UILabel *logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(logoBorderView.frame.origin.x, CGRectGetMaxY(logoBorderView.frame) + 10,
                                                                   logoBorderView.frame.size.width, 0)];
    logoLabel.font = [UIFont igtBoldFontWithSize:IGTFontSizeSubheader];
    logoLabel.textAlignment = NSTextAlignmentCenter;
    logoLabel.textColor = logoColor;
    logoLabel.numberOfLines = 0;
    logoLabel.attributedText = [[NSAttributedString alloc] initWithString:title
                                                               attributes:@{NSKernAttributeName : @7}];
    // Resize to the appropriate height and place back at the center.
    [logoLabel sizeToFit];
    logoLabel.frame = CGRectMake((self.frame.size.width - logoLabel.frame.size.width) / 2.0, CGRectGetMaxY(logoBorderView.frame) + 10,
                                 logoLabel.frame.size.width, logoLabel.frame.size.height);

    [self addSubview:logoLabel];
}

@end
