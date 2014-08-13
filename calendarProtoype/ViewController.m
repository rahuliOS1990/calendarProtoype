//
//  ViewController.m
//  calendarProtoype
//
//  Created by R. Sharma on 8/5/14.
//  Copyright (c) 2014 AgileMobileDev. All rights reserved.
//

#import "ViewController.h"
#import "LSEventEditVC.h"

@interface ViewController ()
{
    EKEventStore *eventStore;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    eventStore = [[EKEventStore alloc] init];
    
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        /* This code will run when uses has made his/her choice */
        
        if (error)
        {
            // display error message here
            NSLog(@"errrot fsdfsd");
        }
        else if (!granted)
        {
            NSLog(@"denied");
            // display access denied error message here
        }
        else
        {
            NSLog(@"access granteed");
            // access granted
            [eventStore refreshSourcesIfNecessary];
            
            for (EKCalendar *calendar in eventStore.calendars) {
                NSLog(@"calendar type %d %@", calendar.type,calendar.title);
                NSLog(@"calendart allow content %d",calendar.allowsContentModifications);
            }
        }
        
        
    }];
    
    
    
   


}

-(IBAction)btnPresentEventEditVC:(id)sender
{
    LSEventEditVC *eventeditVC=[[LSEventEditVC alloc] init];
    eventeditVC.eventStore=eventStore;
    
    eventeditVC.delegate=eventeditVC;

    
    
    eventeditVC.editViewDelegate=self;
    
    
    // present EventsAddViewController as a modal view controller
    [self presentViewController:eventeditVC animated:YES completion:^{
      
    }];
    
}


-(void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action
{
    NSLog(@"Clicked Cancel or Done");
  
      NSLog(@"control;er %@",controller.event);
    [self dismissViewControllerAnimated:YES completion:^{
      
        
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
