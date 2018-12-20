//
//  SelectViewModel.m
//  U6SIA
//
//  Created by Tanzilya Yakshimbetova on 12/20/18.
//  Copyright © 2018 Tanzilya Yakshimbetova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectViewModel.h"
#import "AppDelegate.h"
#import "SelectView.h"
#import "Constants.h"
#import "ApiManager.h"
#import "CountryModel.h"
#import "DataManager.h"



@interface SelectViewModel () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, retain) NSArray<DataModel*> *items;
@property (nonatomic, assign) DataType type;
@property (nonatomic, strong) SelectView *view;

@end

@implementation SelectViewModel

- (instancetype) initWithType:(DataType)type view:(SelectView*)view {
    self = [super init];
    if (self) {
        self.type = type;
        self.view = view;
        [self setup];
    }
    return self;
}

- (void) setup {
    WEAKIFY_SELF
    self.view.onClick = ^{
        STRONGIFY_SELF
        
        if (![self isPreviousSelected]) {
            return;
        }
        
        
        if (self.type == CountryDataType) {
            [[ApiManager sharedManager] getCountries:^(BOOL success, NSArray<CountryModel*> * _Nonnull countries) {
                if (success) {
                    self.items = countries;
                    [self showPicker];
                }
            }];
        } else if (self.type == CityDataType) {
            [[ApiManager sharedManager] getCities:[DataManager sharedManager].selectedCountry.idCountry
                                       completion:^(BOOL success, NSArray * _Nonnull cities) {
                if (success) {
                    self.items = cities;
                    [self showPicker];
                }
            }];
        } else if (self.type == UniversityDataType) {
            [[ApiManager sharedManager] getUniversities:[DataManager sharedManager].selectedCountry.idCountry
                                                 cityId:[DataManager sharedManager].selectedCity.idCity
                                             completion:^(BOOL success, NSArray * _Nonnull universities) {
                                                 if (success) {
                                                     self.items = universities;
                                                     [self showPicker];
                                                 }
                                             }];
        }
        
    };
    
}

- (BOOL) isPreviousSelected {
    if (self.type == CountryDataType) {
        return true;
    }
    else if (self.type == CityDataType) {
        return [DataManager sharedManager].selectedCountry != nil;
    }
    else if (self.type == UniversityDataType) {
        return [DataManager sharedManager].selectedCountry != nil && [DataManager sharedManager].selectedCity != nil;
    }
    return false;
}

- (UIViewController*) rootViewController {
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return delegate.window.rootViewController;
}

- (void)showPicker
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select from the list" message:@"\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet setModalInPopover:true];
    CGRect pickerFrame = CGRectMake(7, 40, UIScreen.mainScreen.bounds.size.width-30, 150);
    UIPickerView *picker = [[UIPickerView alloc]initWithFrame:pickerFrame];
    picker.delegate = self;
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        
        [self.rootViewController dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (self.items.count < 1) {
            [self.rootViewController dismissViewControllerAnimated:YES completion:^{
            }];
            return;
        }
        DataModel *item = self.items[[picker selectedRowInComponent:0]];
        if (self.type == CountryDataType) {
            [DataManager sharedManager].selectedCountry = item;
        } else if (self.type == CityDataType) {
            [DataManager sharedManager].selectedCity = item;
        } else {
            [DataManager sharedManager].selectedUniversity = item;
        }
        [self.view configureWithText:item.title];
        
        [self.rootViewController dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    
    [self.rootViewController presentViewController:actionSheet animated:YES completion:nil];
    
    
    [actionSheet.view addSubview:picker];
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.items count];
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    DataModel *item = [self.items objectAtIndex:row];
    return item.title;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}


@end
