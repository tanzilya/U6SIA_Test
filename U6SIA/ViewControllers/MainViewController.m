//
//  MainViewController.m
//  U6SIA
//
//  Created by Tanzilya Yakshimbetova on 12/19/18.
//  Copyright © 2018 Tanzilya Yakshimbetova. All rights reserved.
//

#import "MainViewController.h"
#import "SelectView.h"
#import "ButtonView.h"
@class DetailViewController;
#import "U6SIA-Swift.h"
#import "CountryModel.h"
#import "SelectViewModel.h"
#import "Constants.h"


@interface MainViewController ()
@property (nonatomic, retain) SelectView* vCountry;
@property (nonatomic, retain) SelectView* vCity;
@property (nonatomic, retain) SelectView* vUniversities;
@property (nonatomic, retain) ButtonView *btnSearch;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadCountries];
}

- (void)loadCountries {

}


- (void) setupUI {
    
    self.title = @"Search";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.vCountry = [[SelectView alloc] initWithTitle:@"COUNTRY"];
    self.vCountry.translatesAutoresizingMaskIntoConstraints = NO;
    SelectViewModel *countryModel = [[SelectViewModel alloc] initWithType:CountryDataType view:self.vCountry];
    self.vCountry.viewModel = countryModel;
    
    self.vCity = [[SelectView alloc] initWithTitle:@"CITY"];
    self.vCity.translatesAutoresizingMaskIntoConstraints = NO;
    SelectViewModel *cityModel = [[SelectViewModel alloc] initWithType:CityDataType view:self.vCity];
    self.vCity.viewModel = cityModel;

    self.vUniversities = [[SelectView alloc] initWithTitle:@"UNIVERSITY"];
    self.vUniversities.translatesAutoresizingMaskIntoConstraints = NO;
    SelectViewModel *unversityModel = [[SelectViewModel alloc] initWithType:UniversityDataType view:self.vUniversities];
    self.vUniversities.viewModel = unversityModel;
    
    self.btnSearch = [[ButtonView alloc] initWithTitle:@"search"];
    WEAKIFY_SELF
    self.btnSearch.onClick = ^{
        STRONGIFY_SELF
        DetailViewController *vc = [DetailViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    
    [self.view addSubview:self.vCountry];
    [self.view addSubview:self.vCity];
    [self.view addSubview:self.vUniversities];
    [self.view addSubview:self.btnSearch];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[vCountry]-15-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"vCountry": self.vCountry}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[vCity]-15-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"vCity": self.vCity}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[vUniversities]-15-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"vUniversities": self.vUniversities}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[btnSearch]-15-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"btnSearch": self.btnSearch}]];


    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[vCountry(height)]-10-[vCity(height)]-10-[vUniversities(height)]-(>=10)-[btnSearch(60)]-15-|"
                                                                      options:0
                                                                      metrics:@{@"height":@(self.vCountry.height)}
                                                                        views:@{@"vCountry": self.vCountry,
                                                                                @"vCity": self.vCity,
                                                                                @"vUniversities": self.vUniversities,
                                                                                @"btnSearch": self.btnSearch}]];


}




@end
