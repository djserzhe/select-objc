//
//  ScanBarcodeViewController.m
//  Select
//
//  Created by Бобер on 11.06.16.
//  Copyright © 2016 Serzhe Development. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ScanBarcodeViewController.h"

@interface ScanBarcodeViewController () <AVCaptureMetadataOutputObjectsDelegate>
{

AVCaptureSession *_session;
AVCaptureDevice *_device;
AVCaptureDeviceInput *_input;
AVCaptureMetadataOutput *_output;
AVCaptureVideoPreviewLayer *_prevLayer;
UILabel *messageLabel;
__weak IBOutlet UIView *frameView;

}

@end

@implementation ScanBarcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    } else {
        NSLog(@"Error: %@", error);
    }
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];
    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _prevLayer.frame = self.view.bounds;
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_prevLayer];
    [self updateCaptureVideoOrientation];
    frameView.layer.borderColor = [UIColor greenColor].CGColor;
    frameView.layer.borderWidth = 1;
    frameView.layer.cornerRadius = 5;
    [self.view bringSubviewToFront:frameView];
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(authStatus != AVAuthorizationStatusAuthorized) {
        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        messageLabel.text = @"Unable to get access to the camera. Check settings.";
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.numberOfLines = 0;
        [self.view addSubview:messageLabel];
    }
    
    // Width constraint, half of parent view width
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_prevLayer
//                                                          attribute:NSLayoutAttributeWidth
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.view
//                                                          attribute:NSLayoutAttributeWidth
//                                                         multiplier:1
//                                                           constant:0]];
//    
//    // Height constraint, half of parent view height
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_prevLayer
//                                                          attribute:NSLayoutAttributeHeight
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.view
//                                                          attribute:NSLayoutAttributeHeight
//                                                         multiplier:1
//                                                           constant:0]];
//    
//    // Center horizontally
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_prevLayer
//                                                          attribute:NSLayoutAttributeCenterX
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.view
//                                                          attribute:NSLayoutAttributeCenterX
//                                                         multiplier:1
//                                                           constant:0]];
//    
//    // Center vertically
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_prevLayer
//                                                          attribute:NSLayoutAttributeCenterY
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.view
//                                                          attribute:NSLayoutAttributeCenterY
//                                                         multiplier:1
//                                                           constant:0]];
    
    [_session startRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                [_session stopRunning];
                
                if([metadata.type isEqualToString:AVMetadataObjectTypeEAN13Code]){
                    if ([detectionString hasPrefix:@"0"] && [detectionString length] > 1)
                        detectionString = [detectionString substringFromIndex:1];
                }
                
                NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"variables"];
                NSMutableDictionary *variables = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                
                [variables setObject:detectionString forKey:self.varName];
                
                data = [NSKeyedArchiver archivedDataWithRootObject:variables];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"variables"];
                
                [self.navigationController popViewControllerAnimated:YES];
                break;
            }
        }
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [_prevLayer removeFromSuperlayer];
    _prevLayer.frame = self.view.bounds;
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_prevLayer];
    [self updateCaptureVideoOrientation];
    [self.view bringSubviewToFront:frameView];
}

-(void)updateCaptureVideoOrientation {

    if (messageLabel != nil) {
        [messageLabel removeFromSuperview];
        messageLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view addSubview:messageLabel];
    }
    
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait)
        _prevLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    else if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        _prevLayer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
    else if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)
        _prevLayer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeRight;
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
