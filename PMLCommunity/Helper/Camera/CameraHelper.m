

#import "CameraHelper.h"
//#import <AVFoundation/AVFoundation.h>
//#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface CameraHelper () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, copy) DidFinishTakeMediaCompletionBlock didFinishTakeMediaCompletion;
@property(nonatomic,strong) UIImagePickerController *imagePickerController;
@end

@implementation CameraHelper

+ (instancetype)helper
{
    static dispatch_once_t onceToken;
    static CameraHelper * helper = nil;
    dispatch_once(&onceToken, ^{
        helper = [[self alloc]init];
    });
    return helper;
}

-(UIImagePickerController *)imagePickerController{
    
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.allowsEditing = YES;
        _imagePickerController.delegate = self;
        [_imagePickerController.navigationBar setTranslucent:false];
    }
    return _imagePickerController;
}


- (void)showPickerViewControllerSourceType:(UIImagePickerControllerSourceType)sourceType onViewController:(UIViewController *)viewController completion:(DidFinishTakeMediaCompletionBlock)completion
{
    
    if (![UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        completion([NSError errorWithDomain:kInternationalContent(@"相机或者相册不可用,请在设置中打开对应的访问权限") code:-1 userInfo:nil], nil);
        return;
    }
    
    self.didFinishTakeMediaCompletion = completion;
    self.imagePickerController.sourceType = sourceType;
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        self.imagePickerController.mediaTypes =  [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    }
    
    [viewController presentViewController:self.imagePickerController animated:YES completion:NULL];
}

- (void)dismissPickerViewController:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   // NSLog(@"get the media info: %@", info);
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        //获取图片对象
        UIImage* image;
        if (picker.allowsEditing) {
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        }else {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        self.didFinishTakeMediaCompletion ? self.didFinishTakeMediaCompletion(nil,imageData) : nil;
        
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        //获取视频文件的url
        NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
        
        //1.保存视频到相册
        NSData *videoData = [NSData dataWithContentsOfURL:mediaURL];
        self.didFinishTakeMediaCompletion ? self.didFinishTakeMediaCompletion(nil,videoData) : nil;
    }
    //退出
    [self dismissPickerViewController:picker];
    //清除块
    self.didFinishTakeMediaCompletion = nil;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissPickerViewController:picker];
    //清除块
    if (self.didFinishTakeMediaCompletion) {
        self.didFinishTakeMediaCompletion([NSError errorWithDomain:kInternationalContent(@"用户取消") code:-2 userInfo:nil], nil);
        self.didFinishTakeMediaCompletion = nil;
    }
    
}

@end
