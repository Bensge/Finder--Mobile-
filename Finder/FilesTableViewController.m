//
//  FilesTableViewController.m
//  Finder
//
//  Created by Benno Krauss on 05.09.12.
//  Copyright (c) 2012 Benno Krauss. All rights reserved.
//

#import "FilesTableViewController.h"

@interface FilesTableViewController (){
    NSMutableArray *dataSource;
}

@end

@implementation FilesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (self.path == nil) self.path = @"/";
    
    self.title = [self.path lastPathComponent];
    
    NSError *error = nil;
    dataSource = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:&error] mutableCopy];
    if (error != nil){
        NSLog(@"Error reading path: %@",error);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    // Configure the cell...
    cell.textLabel.text = [dataSource objectAtIndex:indexPath.row];
    
    
    BOOL isFolder = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",self.path,[dataSource objectAtIndex:indexPath.row]] isDirectory:&isFolder];
    if (!isFolder){
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isFolder = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",self.path,[dataSource objectAtIndex:indexPath.row]] isDirectory:&isFolder];
    if (!isFolder){
        NSLog(@"Is a file...");
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"This is a file. You can't open this" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    
    // Navigation logic may go here. Create and push another view controller.
    
    FilesTableViewController *nextViewController = [[FilesTableViewController alloc] initWithStyle:UITableViewStylePlain];
     
    nextViewController.path = [NSString stringWithFormat:@"%@/%@/",self.path,[dataSource objectAtIndex:indexPath.row]];
     
    
     // Pass the selected object to the new view controller.
    
    [self.navigationController pushViewController:nextViewController animated:YES];
     
}



-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSError *error;
    NSDictionary *details = [[NSFileManager defaultManager] attributesOfItemAtPath:[NSString stringWithFormat:@"%@/%@",self.path,[dataSource objectAtIndex:indexPath.row]] error:&error];
    FileDetailsViewController *controller = [[FileDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [controller setFileName:[dataSource objectAtIndex:indexPath.row]];
    [controller setDetails:details];
    
    //Present the details controller
    
    [self.navigationController pushViewController:controller animated:YES];
    
}


#pragma mark - UIViewController stuff

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

@end
