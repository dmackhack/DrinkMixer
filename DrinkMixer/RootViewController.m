//
//  RootViewController.m
//  DrinkMixer
//
//  Created by David Mackenzie on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize drinks=drinks_, addButton=addButton_, splitViewDetailView=splitViewDetailView_;


- (IBAction) addDrink:(id)sender
{
    NSLog(@"Add Button clicked");
    AddDrinkViewController* addDrinkViewController = [[AddDrinkViewController alloc] initWithNibName:@"DetailedDrinkViewController" bundle:nil];
    addDrinkViewController.drinks = drinks_;
    
    UINavigationController* addDrinkNavController = [[UINavigationController alloc] initWithRootViewController:addDrinkViewController];
    
    [self presentModalViewController:addDrinkNavController animated:YES];
    [addDrinkViewController release];
    [addDrinkNavController release];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"View Did Load");
    
    self.navigationItem.rightBarButtonItem = addButton_;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //drinks_ = [[NSArray alloc] initWithObjects: @"The Michelle", @"The Dmack", @"Sex on the Beach", nil];
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"DrinksList" ofType:@"plist"];
    drinks_ = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    //NSLog(@"Size: %@", [drinks_ count]);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)applicationDidEnterBackground
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"DrinksList" ofType:@"plist"];
    [self.drinks writeToFile:filePath atomically:YES];
}


 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return YES;
}


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [drinks_ count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.
    NSDictionary* drink = [drinks_ objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = [drink valueForKey:NAME_KEY];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [drinks_ removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected Index: %@", indexPath);
    
    if (!self.editing)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [self.splitViewDetailView drinkChanged: [self.drinks objectAtIndex:indexPath.row]];
        }
        else
        {
            DetailedDrinkViewController *detailViewController = [[DetailedDrinkViewController alloc] initWithNibName:@"DetailedDrinkViewController" bundle:nil];
        
            detailViewController.drink = [drinks_ objectAtIndex:indexPath.row];
        
        
            // Pass the selected object to the new view controller.
            [self.navigationController pushViewController:detailViewController animated:YES];
            [detailViewController release];
        }
    }
    else
    {        
        NSLog(@"trying to edit drink");
        AddDrinkViewController* addDrinkViewController = [[AddDrinkViewController alloc] initWithNibName:@"DetailedDrinkViewController" bundle:nil];
        addDrinkViewController.drink = [drinks_ objectAtIndex:indexPath.row];
        addDrinkViewController.drinks = drinks_;
        
        UINavigationController* addDrinkNavController = [[UINavigationController alloc] initWithRootViewController:addDrinkViewController];
        
        [self presentModalViewController:addDrinkNavController animated:YES];
        [addDrinkViewController release];
        [addDrinkNavController release];
    }
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [drinks_ release];
    [addButton_ release];
    [splitViewDetailView_ release];
    [super dealloc];
}

@end
