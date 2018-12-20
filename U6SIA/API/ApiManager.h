//
//  ApiManager.h
//  U6SIA
//
//  Created by Tanzilya Yakshimbetova on 12/19/18.
//  Copyright © 2018 Tanzilya Yakshimbetova. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CountryModel;
@class CityModel;
@class UniversityModel;
@class UniversityInfoModel;


NS_ASSUME_NONNULL_BEGIN

@interface ApiManager : NSObject

+ (instancetype)sharedManager;
- (void)getCountries:(void (^)(BOOL success, NSArray<CountryModel*> *countries))completion;
- (void)getCities:(NSString*)countryId
       completion:(void (^)(BOOL success, NSArray<CityModel*> *cities))completion;
- (void)getUniversities:(NSString*)countryId
                 cityId:(NSString*)cityId
             completion:(void (^)(BOOL success, NSArray<UniversityModel*> *universities))completion;
- (void)getUniversityInfo:(NSString*)placeQuery
               completion:(void (^)(BOOL success, UniversityInfoModel  * _Nullable  info))completion;


@end

NS_ASSUME_NONNULL_END
