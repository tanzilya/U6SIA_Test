//
//  ApiManager.m
//  U6SIA
//
//  Created by Tanzilya Yakshimbetova on 12/19/18.
//  Copyright © 2018 Tanzilya Yakshimbetova. All rights reserved.
//

#import "ApiManager.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "CountryModel.h"
#import "CityModel.h"
#import "UniversityModel.h"
#import "UniversityInfoModel.h"

#define VK_API_SECURITY_KEY  @"FfzpLBpZeY7TB0G487Ii"
#define VK_API_ACCESS_KEY  @"3232736e3232736e3232736e293255e49f332323232736e6e2b24bf1129fc7e7a8e45a1"
#define VK_API_VERSION @"5.92"

#define BASE_URL @"https://api.vk.com"

#define GOOGLE_API_KEY @"AIzaSyDkWtbqOQ7i4Bx8otAFrPSwHWkKCOE7R1w"

@interface ApiManager ()
@property (nonatomic, strong) AFHTTPSessionManager* manager;
@end


@implementation ApiManager

+ (instancetype)sharedManager {
    static ApiManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    }
    return self;
}


- (void)getCountries:(void (^)(BOOL success, NSArray<CountryModel*> *countries))completion {
    [self.manager GET:[NSString stringWithFormat:@"%@/%@", BASE_URL, @"method/database.getCountries"]
      parameters:@{@"need_all": @(1),
                   @"count": @(999),
                   @"access_token": VK_API_ACCESS_KEY,
                   @"v": VK_API_VERSION,
                   @"lang": @"en"
                   }
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (!responseObject[@"response"][@"items"]) {
             completion(NO, @[]);
             return;
         }
         NSMutableArray *countries = [NSMutableArray new];
         NSArray *items = responseObject[@"response"][@"items"];
         for (int i = 0; i < items.count; i++) {
             NSDictionary *item = [items objectAtIndex:i];
             CountryModel *model = [CountryModel new];
             model.idCountry = item[@"id"];
             model.title = item[@"title"];
             [countries addObject:model];
         }
         completion(YES, countries);
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         completion(NO, @[]);
     }
     ];


}

- (void)getCities:(NSString*)countryId completion:(void (^)(BOOL success, NSArray<CityModel*> *cities))completion {
    [self.manager GET:[NSString stringWithFormat:@"%@/%@", BASE_URL, @"method/database.getCities"]
      parameters:@{@"country_id": countryId,
                   @"need_all": @(1),
                   @"count": @(999),
                   @"access_token": VK_API_ACCESS_KEY,
                   @"v": VK_API_VERSION,
                   @"lang": @"en"
                   }
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (!responseObject[@"response"][@"items"]) {
             completion(NO, @[]);
             return;
         }
         
         NSMutableArray *cities = [NSMutableArray new];
         NSArray *items = responseObject[@"response"][@"items"];
         for (int i = 0; i < items.count; i++) {
             NSDictionary *item = [items objectAtIndex:i];
             CityModel *model = [CityModel new];
             model.idCity = item[@"id"];
             model.title = item[@"title"];
             [cities addObject:model];
         }
         completion(YES, cities);
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         completion(NO, @[]);
     }
     ];
    
    
}

- (void)getUniversities:(NSString*)countryId
                 cityId:(NSString*)cityId
             completion:(void (^)(BOOL success, NSArray<UniversityModel*> *universities))completion {
    [self.manager GET:[NSString stringWithFormat:@"%@/%@", BASE_URL, @"method/database.getUniversities"]
      parameters:@{@"country_id": countryId,
                   @"city_id": cityId,
                   @"count": @(999),
                   @"access_token": VK_API_ACCESS_KEY,
                   @"v": VK_API_VERSION,
                   @"lang": @"en"
                   }
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (!responseObject[@"response"][@"items"]) {
             completion(NO, @[]);
             return;
         }
         NSMutableArray *universities = [NSMutableArray new];
         NSArray *items = responseObject[@"response"][@"items"];
         for (int i = 0; i < items.count; i++) {
             NSDictionary *item = [items objectAtIndex:i];
             UniversityModel *model = [UniversityModel new];
             model.idUniversity = item[@"id"];
             model.title = item[@"title"];
             [universities addObject:model];
         }
         completion(YES, universities);
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         completion(NO, @[]);
     }
     ];
}

- (void)getUniversityInfo:(NSString*)placeQuery
             completion:(void (^)(BOOL success, UniversityInfoModel *info))completion {
    [self.manager GET:@"https://maps.googleapis.com/maps/api/place/findplacefromtext/json"
           parameters:@{@"input": placeQuery,
                        @"inputtype": @"textquery",
                        @"fields": @"formatted_address,name,geometry",
                        @"key": GOOGLE_API_KEY}
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (!responseObject[@"candidates"] || !((NSArray*)responseObject[@"candidates"]).firstObject) {
             completion(NO, nil);
             return;
         }
         UniversityInfoModel *info = [UniversityInfoModel new];
         NSDictionary *item = ((NSArray*)responseObject[@"candidates"]).firstObject;
         info.formattedAddress = item[@"formatted_address"];
         info.name = item[@"name"];
         NSDictionary *location = item[@"geometry"][@"location"];
         info.latitude = [location[@"lat"] floatValue];
         info.longitude = [location[@"lng"] floatValue];
         completion(YES, info);
     }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         completion(NO, nil);
     }
     ];
}


@end
