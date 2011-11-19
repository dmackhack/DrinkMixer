//
//  AddDrinkViewController.m
//  DrinkMixer
//
//  Created by David Mackenzie on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddDrinkViewController.h"


@implementation AddDrinkViewController

- (IBAction) cancel: (id) sender
{
    NSLog(@"Cancel");
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction) done: (id) sender
{
    NSLog(@"Done.");
    
    if (self.drink != nil)
    {
        [drinks_ removeObject:self.drink];
        self.drink = nil;
    }
    
    NSMutableDictionary *newDrink = [[NSMutableDictionary alloc] init];
    [newDrink setValue: nameField_.text forKey: NAME_KEY];
    [newDrink setValue: descriptionView_.text forKey: DESCRIPTION_KEY];
    [newDrink setValue: ingredientsView_.text forKey: INGREDIENTS_KEY];
    
    [drinks_ addObject:newDrink];
    [newDrink release];
    
    NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:NAME_KEY ascending:YES selector:@selector(caseInsensitiveCompare:)];
    [drinks_ sortUsingDescriptors:[NSArray arrayWithObject:nameSorter]];
    [nameSorter release];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
