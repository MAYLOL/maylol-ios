
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^DidFinishTakeMediaCompletionBlock)(NSError *error, NSData *data);

@interface CameraHelper : NSObject

+ (instancetype)helper;


- (void)showPickerViewControllerSourceType:(UIImagePickerControllerSourceType)sourceType onViewController:(UIViewController *)viewController completion:(DidFinishTakeMediaCompletionBlock)completion;


@end
