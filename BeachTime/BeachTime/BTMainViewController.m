//
//  BTMainViewController.m
//  BeachTime
//
//  Created by Guy Kahlon on 5/9/14.
//  Copyright (c) 2014 GuyKahlon. All rights reserved.
//

#import "BTMainViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface BTMainViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescLabel;

@end

@implementation BTMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *latitude = @"32.067";
    NSString *longitude = @"34.767";
    
    NSString *url = [NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v1/weather.ashx?q=%@%%2C+%@&format=json&num_of_days=1&key=n6ff66zx6qxb2s6wtvwvsubq",latitude, longitude];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
             NSLog(@"JSON: %@", responseObject);
             NSDictionary *dicData = (NSDictionary *)responseObject[@"data"];
             
             NSArray* current_condition = dicData[@"current_condition"];
             NSDictionary *condition = current_condition.firstObject;
             
             
             NSArray * weatherIconUrl = condition[@"weatherIconUrl"];
             NSDictionary *weatherIcon = weatherIconUrl.firstObject;
             
             UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:weatherIcon[@"value"]]]];
             self.weatherImage.image = image;
             
             self.temperatureLabel.text = [NSString stringWithFormat:@"%@ °c", condition[@"temp_C"]];
             
             NSArray * weatherDesc = condition[@"weatherDesc"];
             NSDictionary *desc = weatherDesc.firstObject;
             
             self.weatherDescLabel.text = desc[@"value"];
            
             
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
