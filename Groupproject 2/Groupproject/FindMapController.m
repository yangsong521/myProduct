//
//  FindMapController.m
//  Groupproject
//
//  Created by lanou3g on 15/6/29.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FindMapController.h"
#import "AnnotationModel.h"

@interface FindMapController ()<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation FindMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AnnotationModel *anno = [[AnnotationModel alloc]init];
    anno.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    [self.mapView addAnnotation:anno];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
