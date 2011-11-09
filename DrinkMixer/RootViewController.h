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

@interface RootViewController : UITableViewController {

    NSArray* drinks_;
    UIBarButtonItem* addButton_;
    
}

@property (nonatomic, retain) NSArray* drinks;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* addButton;

- (IBAction) addDrink: (id) sender;

@end
