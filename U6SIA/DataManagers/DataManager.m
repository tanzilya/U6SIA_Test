//
//  DataManager.m
//  U6SIA
//
//  Created by Tanzilya Yakshimbetova on 12/20/18.
//  Copyright © 2018 Tanzilya Yakshimbetova. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+ (instancetype)sharedManager {
    static DataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


@end
