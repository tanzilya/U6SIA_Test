//
//  ButtonView.m
//  U6SIA
//
//  Created by Tanzilya Yakshimbetova on 12/19/18.
//  Copyright © 2018 Tanzilya Yakshimbetova. All rights reserved.
//

#import "ButtonView.h"

@interface ButtonView()

@property (nonatomic, retain) NSString *title;
@end

@implementation ButtonView

- (instancetype) initWithTitle:(NSString*)title {
    self = [super init];
    if (self) {
        self.title = title;
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    self.translatesAutoresizingMaskIntoConstraints = false;
    [self setTitle:self.title.uppercaseString forState:UIControlStateNormal];
    [self setTitle:self.title.uppercaseString forState:UIControlStateHighlighted];
    self.backgroundColor = UIColor.grayColor;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self addTarget:self action:@selector(doClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) doClick {
    if (self.onClick) {
        self.onClick();
    }
}


@end
