//
//  ViewController.m
//  s3sample
//
//  Created by Lohit Talasila on 2015-10-05.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark S3 stuff
- (void)uploadToS3{
  // get the image
  UIImage *img = _selectedImage.image;
  
  // create a local image that we can use to upload to s3
  NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"image.png"];
  NSData *imageData = UIImagePNGRepresentation(img);
  [imageData writeToFile:path atomically:YES];
  
  // once the image is saved we can use the path to create a local fileurl
  NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
  
  AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
  
  AWSS3TransferManagerUploadRequest *uploadRequest = [AWSS3TransferManagerUploadRequest new];
  
  uploadRequest.contentLength = [NSNumber numberWithUnsignedLongLong:_filesize];
  
  
  // next we set up the S3 upload request manager
  uploadRequest = [AWSS3TransferManagerUploadRequest new];
  uploadRequest.bucket = @"s3-demoweb-objectivec";
  uploadRequest.ACL = AWSS3ObjectCannedACLPublicRead;
  
  uploadRequest.key = @"foldername/image.png";
  uploadRequest.contentType = @"image/png";
  uploadRequest.body = url;
  
  __weak ViewController *weakSelf = self;
  
  uploadRequest.uploadProgress =^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend){
    dispatch_sync(dispatch_get_main_queue(), ^{
      weakSelf.amountUploaded = totalBytesSent;
      weakSelf.filesize = totalBytesExpectedToSend;
      [weakSelf update];
      
    });
  };
  
  
  [[transferManager upload:uploadRequest] continueWithBlock:^id(AWSTask *task) {
    // Do something with the response
    if (task.error) {
      NSLog(@"Error from 'saveRecord:streamName:': %@", task.error);
      return nil;
    } else {
      NSLog(@"passed");
    }
    return nil;
  }];
}

- (void) update{
  _progressLabel.text = [NSString stringWithFormat:@"Uploading:%.0f%%", ((float)self.amountUploaded/ (float)self.filesize) * 100];
}


#pragma mark camera and ibaction stuff
- (IBAction)cameraBtnClicked:(id)sender{
  self.imagePickerController = [[UIImagePickerController alloc] init];
  self.imagePickerController.delegate = self;
  self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
  [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (IBAction)galleryBtnClicked:(id)sender{
  self.imagePickerController = [[UIImagePickerController alloc] init];
  self.imagePickerController.delegate = self;
  self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
  [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (IBAction)uploadBtnClicked:(id)sender{
  [self createLoadingView];
  [self uploadToS3];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  [picker dismissViewControllerAnimated:YES completion:nil];
  self.selectedImage.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

- (void)createLoadingView{
  _loadingBg = [[UIView alloc] initWithFrame:self.view.frame];
  [_loadingBg setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.35]];
  [self.view addSubview:_loadingBg];
  
  _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 50)];
  _progressView.center = self.view.center;
  [_progressView setBackgroundColor:[UIColor whiteColor]];
  [_loadingBg addSubview:_progressView];
  
  _progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 50)];
  [_progressLabel setTextAlignment:NSTextAlignmentCenter];
  [_progressView addSubview:_progressLabel];
  
  _progressLabel.text = @"Uploading:";
  
}

- (void)removeLoadingView{
  
  [_loadingBg removeFromSuperview];
  
}

@end
