//
//  LSEventEditVC.m
//  calendarProtoype
//
//  Created by R. Sharma on 8/5/14.
//  Copyright (c) 2014 AgileMobileDev. All rights reserved.
//

#import "LSEventEditVC.h"
#import "LSEventEditTbleViewCell.h"

@interface LSEventEditVC()
{
    id _ekEventEditorDelegate;
    
    BOOL isOpenDatePicker;
    NSIndexPath *selectedIndexPathToInsertDatePicker;
    NSDateFormatter *dateFormatter;
    
    NSDate *dateStrt;
    NSDate *dateEnd;
    
    UITableView *tblView;
    
    BOOL isDisplayRedAlertMessage;

    NSIndexPath *indexPathEndDate;
}

@end

@implementation LSEventEditVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy hh:mm a"];
    indexPathEndDate=[NSIndexPath indexPathForRow:2 inSection:1];
    dateStrt=[NSDate date];
    dateEnd=[NSDate dateWithTimeInterval:60*60 sinceDate:dateStrt];
    
    // Do any additional setup after loading the view.
    
    
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[UITableViewController class]]) {
        UITableView *tableView = ((UITableViewController *)viewController).tableView;
        tblView=tableView;
        if ([tableView.delegate isKindOfClass:NSClassFromString(@"EKEventEditor")]) {
            _ekEventEditorDelegate=tableView.delegate;
        }
        
        
        [tableView setDelegate:self];
        [tableView setDataSource:self];
    }
    
}






#pragma mark- Table View Delegate & Data Sources


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    NSLog(@"number of sections %d",[_ekEventEditorDelegate numberOfSectionsInTableView:tableView]);
    return [_ekEventEditorDelegate numberOfSectionsInTableView:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isOpenDatePicker && section==1) {
        return [_ekEventEditorDelegate tableView:tableView numberOfRowsInSection:section]+1;
    }
    NSLog(@"number of rows %d ",[_ekEventEditorDelegate tableView:tableView numberOfRowsInSection:section]);
    return [_ekEventEditorDelegate tableView:tableView numberOfRowsInSection:section];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    
    if (isOpenDatePicker && indexPath.section==selectedIndexPathToInsertDatePicker.section && indexPath.row==selectedIndexPathToInsertDatePicker.row) {
        
        
        static NSString *cellIdentifier=@"DatePciker";
        cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            UIDatePicker *datePicker=[[UIDatePicker alloc] init];
            datePicker.date=dateStrt;
            datePicker.tag=110;
            [cell.contentView addSubview:datePicker];
        }
        
        UIDatePicker *datePicker=(UIDatePicker*)[cell.contentView viewWithTag:110];
         [datePicker addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventValueChanged];
        
        
        return cell;
    }
    
    
    else if (indexPath.section==1 && indexPath.row==1) {
        
        static NSString *cellIdentifier=@"Starts";
        cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell==nil) {
            cell=[[LSEventEditTbleViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            
            float x_cord=12;
            float lblStartWidth=70;
            float height=40;
            float totalcellWidth=308;
            
            UILabel *lblStart=[[UILabel alloc] initWithFrame:CGRectMake(x_cord, 0, lblStartWidth,height)];
            [lblStart setFont:[UIFont fontWithName:@"HelveticaNeueInterface-Regular" size:17.0f]];
            lblStart.text=@"Starts";
            // [lblStart setBackgroundColor:[UIColor redColor]];
            [cell.contentView addSubview:lblStart];
            
            x_cord+=lblStartWidth;
            
            
            UILabel *lblStartDate=[[UILabel alloc] initWithFrame:CGRectMake(x_cord, 0, totalcellWidth-x_cord,height)];
            [lblStartDate setFont:[UIFont fontWithName:@"HelveticaNeueInterface-Regular" size:17.0f]];
            
            lblStartDate.textAlignment=NSTextAlignmentRight;
            // [lblStartDate setBackgroundColor:[UIColor blueColor]];
            lblStartDate.tag=110;
            [cell.contentView addSubview:lblStartDate];
            
        }
        
        
        
        
        UILabel *lbl=(UILabel*)[cell.contentView viewWithTag:110];
        lbl.text=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateStrt]];
        if (isDisplayRedAlertMessage) {
            lbl.textColor=[UIColor colorWithRed:204/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
        }
        else
        {
            lbl.textColor=[UIColor blackColor];
        }
        
        return cell;
    }
    else if (indexPath.section==indexPathEndDate.section && indexPath.row==indexPathEndDate.row) {
        
        static NSString *cellIdentifier=@"Ends";
        cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell==nil) {
            cell=[[LSEventEditTbleViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            
            float x_cord=12;
            float lblEndWidth=70;
            float height=40;
            float totalcellWidth=308;
            
            UILabel *lblEnd=[[UILabel alloc] initWithFrame:CGRectMake(x_cord, 0, lblEndWidth,height)];
            [lblEnd setFont:[UIFont fontWithName:@"HelveticaNeueInterface-Regular" size:17.0f]];
            lblEnd.text=@"Ends";
            // [lblStart setBackgroundColor:[UIColor redColor]];
            [cell.contentView addSubview:lblEnd];
            
            x_cord+=lblEndWidth;
            
            
            UILabel *lblEndDate=[[UILabel alloc] initWithFrame:CGRectMake(x_cord, 0, totalcellWidth-x_cord,height)];
            [lblEndDate setFont:[UIFont fontWithName:@"HelveticaNeueInterface-Regular" size:17.0f]];
            
            lblEndDate.textAlignment=NSTextAlignmentRight;
            // [lblStartDate setBackgroundColor:[UIColor blueColor]];
            lblEndDate.tag=110;
            [cell.contentView addSubview:lblEndDate];
            
        }
        
        
        
        
        UILabel *lbl=(UILabel*)[cell.contentView viewWithTag:110];
        lbl.text=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateEnd]];
        if (isDisplayRedAlertMessage) {
            lbl.textColor=[UIColor colorWithRed:204/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
        }
        else
        {
            lbl.textColor=[UIColor blackColor];
        }
        return cell;
    }
    else
    {
        cell=[_ekEventEditorDelegate tableView:tableView cellForRowAtIndexPath:indexPath];
        
        if (indexPath.section==0 && indexPath.row==0) {
            
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:NSClassFromString(@"UITextField")]) {
                    UITextField *txtField=(UITextField*)view;
                    if ([txtField.placeholder isEqualToString:@"Title"]) {
                        [txtField setPlaceholder:@"Add a Focus"];
                    }
                }
            }
            
        }
        
       
        
        
        return cell;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:NSClassFromString(@"LSEventEditTbleViewCell")]) {
      
        LSEventEditTbleViewCell *lsCell=(LSEventEditTbleViewCell*)cell;
        lsCell.isOpened=!lsCell.isOpened;
        
        if (indexPath.section==1 && indexPath.row==1 && lsCell.isOpened) {
            isOpenDatePicker=YES;
            selectedIndexPathToInsertDatePicker=[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
            indexPathEndDate=[NSIndexPath indexPathForRow:3 inSection:1];
            [tableView reloadData];
        }
        else if (indexPath.section==1 && indexPath.row==1 && !lsCell.isOpened) {
            isOpenDatePicker=NO;
            selectedIndexPathToInsertDatePicker=nil;
            indexPathEndDate=[NSIndexPath indexPathForRow:2 inSection:1];
            [tableView reloadData];
            
        }
        else if(indexPath.section==1 && indexPath.row==2 && lsCell.isOpened) {
            isOpenDatePicker=YES;
            selectedIndexPathToInsertDatePicker=[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
            indexPathEndDate=[NSIndexPath indexPathForRow:2 inSection:1];
            [tableView reloadData];
        }
        else if (indexPath.section==1 && indexPath.row==2 && !lsCell.isOpened) {
            isOpenDatePicker=NO;
            selectedIndexPathToInsertDatePicker=nil;
            indexPathEndDate=[NSIndexPath indexPathForRow:2 inSection:1];
            [tableView reloadData];
            
        }
        
    }
    
    
    else
    {
        [_ekEventEditorDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_ekEventEditorDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [_ekEventEditorDelegate tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_ekEventEditorDelegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_ekEventEditorDelegate tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_ekEventEditorDelegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
}


-(NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    return [_ekEventEditorDelegate tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_ekEventEditorDelegate tableView:tableView willSelectRowAtIndexPath:indexPath];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section %d row %d height %f",indexPath.section,indexPath.row,[_ekEventEditorDelegate tableView:tableView heightForRowAtIndexPath:indexPath]);
    
    if (isOpenDatePicker && indexPath.section==selectedIndexPathToInsertDatePicker.section && indexPath.row==selectedIndexPathToInsertDatePicker.row) {
        return 216;
    }
    
    return [_ekEventEditorDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (isDisplayRedAlertMessage && section==1) {
        
    
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(10,-30, 300, 100)];
    [lbl setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0f]];
    [lbl setTextColor:[UIColor colorWithRed:204/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f]];
    lbl.text=@"An event is already scheduled for this time.";
    lbl.textAlignment=NSTextAlignmentCenter;
    //[lbl sizeToFit];
    //  [lbl setBackgroundColor:[UIColor blackColor]];
    return lbl;
    }
    else
        return [_ekEventEditorDelegate tableView:tableView viewForHeaderInSection:section];
}



#pragma mark - Date Selected

-(void)dateSelected:(UIDatePicker*)picker
{
    if (selectedIndexPathToInsertDatePicker.row-1==1) {
        dateStrt=picker.date;
    }
    else if (selectedIndexPathToInsertDatePicker.row-1==2) {
        dateEnd=picker.date;
        
        
        
        NSComparisonResult result=[dateStrt compare:dateEnd];
        BOOL isEndDateBeforeStart=NO;
        
        if(result==NSOrderedAscending)
        {
            NSLog(@"today is less");
        }
        
        else if(result==NSOrderedDescending)
        {
            isEndDateBeforeStart=YES;
        }else
        {
            isEndDateBeforeStart=YES;
        }
        
        if (isEndDateBeforeStart) {
            
            [[[UIAlertView alloc] initWithTitle:nil message:@"End Date should be ahead of Start date" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
            return;
        }
        else
        {
            NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:dateStrt
                                                                         endDate:dateEnd
                                                                       calendars:[self.eventStore calendarsForEntityType:EKEntityTypeEvent]];
            
            // Fetch all events that match the predicate
            NSArray *events = [self.eventStore eventsMatchingPredicate:predicate];
            isDisplayRedAlertMessage=NO;
            NSLog(@"print events  %@",events);

            if (events.count>0) {
                isDisplayRedAlertMessage=YES;
            }
            [tblView reloadData];
        }

        
    }
    [tblView reloadData];
}



@end
