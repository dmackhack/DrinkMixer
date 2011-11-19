//
//  RootViewController.h
//  DrinkMixer
//
//  Created by David Mackenzie on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailedDrinkViewController.h"
#import "AddDrinkViewController.h"
#import "Constants.h"

@class DetailedDrinkViewController;
@interface RootViewController : UITableViewController {

    NSMutableArray* drinks_;
    UIBarButtonItem* addButton_;
    DetailedDrinkViewController* splitViewDetailView_;
    
}

@property (nonatomic, retain) NSArray* drinks;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* addButton;
@property (nonatomic, retain) IBOutlet DetailedDrinkViewController* splitViewDetailView;

- (IBAction) addDrink: (id) sender;

@end
