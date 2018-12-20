//
//  ButtonView.h
//  U6SIA
//
//  Created by Tanzilya Yakshimbetova on 12/19/18.
//  Copyright © 2018 Tanzilya Yakshimbetova. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^click)(void);

@interface ButtonView : UIButton

@property (nonatomic, copy) click onClick;
- (instancetype) initWithTitle:(NSString*)title;

@end

NS_ASSUME_NONNULL_END
