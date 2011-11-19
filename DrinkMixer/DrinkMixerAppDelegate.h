//
//  DrinkMixerAppDelegate.h
//  DrinkMixer
//
//  Created by David Mackenzie on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrinkMixerAppDelegate : NSObject <UIApplicationDelegate> {

    UISplitViewController* splitViewController_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;

@end
