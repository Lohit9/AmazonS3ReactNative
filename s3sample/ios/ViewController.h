//
//  ViewController.h
//  s3sample
//
//  Created by Lohit Talasila on 2015-10-05.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AWSCore/AWSCore.h>
#import <AWSS3/AWSS3.h>
#import <AWSDynamoDB/AWSDynamoDB.h>
#import <AWSSQS/AWSSQS.h>
#import <AWSSNS/AWSSNS.h>

@interface ViewController : UIViewController < UIImagePickerControllerDelegate, UINavigationControllerDelegate >

@property (nonatomic, strong) IBOutlet UIImageView *selectedImage;
@property (nonatomic) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIView *loadingBg;
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UILabel *progressLabel;

@property (nonatomic) uint64_t filesize;
@property (nonatomic) uint64_t amountUploaded;

/*
- (IBAction)cameraBtnClicked:(id)sender;
- (IBAction)galleryBtnClicked:(id)sender;
- (IBAction)uploadBtnClicked:(id)sender;
*/

@end
