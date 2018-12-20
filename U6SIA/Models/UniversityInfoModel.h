//
//  UniversityInfoModel.h
//  U6SIA
//
//  Created by Tanzilya Yakshimbetova on 12/20/18.
//  Copyright © 2018 Tanzilya Yakshimbetova. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UniversityInfoModel : NSObject

@property (nonatomic, retain) NSString *formattedAddress;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;

@end

NS_ASSUME_NONNULL_END
