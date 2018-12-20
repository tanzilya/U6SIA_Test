//
//  SelectViewModel.h
//  U6SIA
//
//  Created by Tanzilya Yakshimbetova on 12/20/18.
//  Copyright © 2018 Tanzilya Yakshimbetova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"
@class SelectView;

typedef enum {
    CountryDataType,
    CityDataType,
    UniversityDataType
} DataType;

NS_ASSUME_NONNULL_BEGIN

@interface SelectViewModel : NSObject

- (instancetype) initWithType:(DataType)type view:(SelectView*)view;

@end

NS_ASSUME_NONNULL_END
