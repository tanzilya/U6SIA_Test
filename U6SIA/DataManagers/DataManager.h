//
//  DataManager.h
//  U6SIA
//
//  Created by Tanzilya Yakshimbetova on 12/20/18.
//  Copyright © 2018 Tanzilya Yakshimbetova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CountryModel.h"
#import "CityModel.h"
#import "UniversityModel.h"
#import "UniversityInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) CountryModel *selectedCountry;
@property (nonatomic, strong) CityModel *selectedCity;
@property (nonatomic, strong) UniversityModel *selectedUniversity;
@property (nonatomic, strong) UniversityInfoModel *universityInfo;

@end

NS_ASSUME_NONNULL_END
