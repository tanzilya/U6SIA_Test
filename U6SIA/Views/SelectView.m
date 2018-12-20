//
//  SelectView.m
//  U6SIA
//
//  Created by Tanzilya Yakshimbetova on 12/19/18.
//  Copyright © 2018 Tanzilya Yakshimbetova. All rights reserved.
//

#import "SelectView.h"
#import "SelectViewModel.h"

@interface SelectView ()
@property (nonatomic, retain) UILabel *lblTitle;
@property (nonatomic, retain) UIButton *btnAction;
@property (nonatomic, retain) UIView *vLine;
@end

@implementation SelectView

- (UIView*) initWithTitle:(NSString*)title {
    self = [super init];
    if (self) {
        [self setupUI];
        self.lblTitle.text = title;
    }
    return self;
}

- (CGFloat) height {
    return 61;
}

#pragma mark ---- Configure ----

- (void) configureWithText:(NSString*) text {
    [self.btnAction setTitle:text forState:UIControlStateNormal];
    [self.btnAction setTitle:text forState:UIControlStateHighlighted];
}


#pragma mark --- Setup ---

- (void) setupUI {
    [self addSubview:self.lblTitle];
    [self addSubview:self.btnAction];
    [self addSubview:self.vLine];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[lblTitle]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:@{@"lblTitle": self.lblTitle}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[btnAction]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"btnAction": self.btnAction}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[vLine]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"vLine": self.vLine}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lblTitle(20)][btnAction(40)][vLine(1)]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"lblTitle": self.lblTitle,
                                                                           @"btnAction": self.btnAction,
                                                                           @"vLine": self.vLine}]];


}

- (void) click:(UIButton*)sender {
    if (self.onClick) {
        self.onClick();
    }
}

#pragma mark ----- Views -----

- (UILabel*) lblTitle {
    if (_lblTitle == nil) {
        _lblTitle = [UILabel new];
        _lblTitle.translatesAutoresizingMaskIntoConstraints = false;
        _lblTitle.textColor = [UIColor blackColor];
        _lblTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0F];
        _lblTitle.textAlignment = NSTextAlignmentLeft;
        _lblTitle.backgroundColor = [UIColor whiteColor];
    }
    return _lblTitle;
}


- (UIButton*)btnAction {
    if (_btnAction == nil) {
        _btnAction = [UIButton new];
        _btnAction.translatesAutoresizingMaskIntoConstraints = NO;
        _btnAction.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0F];
        [_btnAction setTitleColor:[UIColor blackColor]
                            forState:UIControlStateNormal];
        [_btnAction setTitleColor:[UIColor blackColor]
                            forState:UIControlStateHighlighted];
        _btnAction.backgroundColor = [UIColor clearColor];
        [_btnAction setTitle:@"Select" forState:UIControlStateNormal];
        [_btnAction setTitle:@"Select" forState:UIControlStateHighlighted];
        [_btnAction addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAction;
}

- (UIView*) vLine {
    if (_vLine == nil) {
        _vLine = [UIView new];
        _vLine.translatesAutoresizingMaskIntoConstraints = NO;
        _vLine.backgroundColor = [UIColor grayColor];
    }
    return _vLine;
}




@end
