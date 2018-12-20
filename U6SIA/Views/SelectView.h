//
//  SelectView.h
//  U6SIA
//
//  Created by Tanzilya Yakshimbetova on 12/19/18.
//  Copyright © 2018 Tanzilya Yakshimbetova. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectViewModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^click)(void);

@interface SelectView : UIView

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) click onClick;
@property (nonatomic, strong) SelectViewModel *viewModel;

- (UIView*) initWithTitle:(NSString*)title;
- (void) configureWithText:(NSString*) text;

@end

NS_ASSUME_NONNULL_END
