//
//  IWComposeViewController.m
//  ItcastWeibo
//
//  Created by kun on 15/1/25.
//  Copyright (c) 2015年 kun. All rights reserved.
//

/**
 UITextField: 不能换行
 UITextView:  没有提示文字
 */

#import "IWComposeViewController.h"
#import "IWTextView.h"
#import "AFNetworking.h"
#import "IWAccount.h"
#import "IWAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "IWComposeToolbar.h"
#import "IWComposePhotosView.h"

@interface IWComposeViewController () <UITextViewDelegate, IWComposeDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) IWTextView *textView;
@property (nonatomic, strong) IWComposeToolbar *toolbar;
@property (nonatomic, weak) IWComposePhotosView *photosView;
@end

@implementation IWComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏属性
    [self setupNavBar];
    
    // 添加textView
    [self setupTextView];
    
    // 添加toolbar
    [self setupToolbar];
    
    // 添加imageView
    [self setupPhotosView];
}

- (void)setupPhotosView
{
    IWComposePhotosView *photosView = [[IWComposePhotosView alloc] init];
    CGFloat photosViewH = self.textView.frame.size.height;
    CGFloat photosViewW = self.textView.frame.size.width;
    CGFloat photosViewX = 0;
    CGFloat photosViewY = 80;
    photosView.frame = CGRectMake(photosViewX, photosViewY, photosViewW, photosViewH);
    // imageView的父控件
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

- (void)setupToolbar
{
    IWComposeToolbar *toolbar = [[IWComposeToolbar alloc] init];
    toolbar.delegate = self;
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

/**
 *  设置导航栏属性
 */
- (void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";
}

/**
 *  添加textView
 */
- (void)setupTextView
{
    IWTextView *textView = [[IWTextView alloc] init];
    textView.font = [UIFont systemFontOfSize: 15];
    textView.frame = self.view.bounds;
    textView.placeholder = @"分享新鲜事";
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    // 监听textView文字改变的通知
    [IWNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 监听键盘的通知
    [IWNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [IWNotificationCenter addObserver:self selector:@selector(keyboardWillHinde:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillHinde:(NSNotification *)note
{
    // 取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

- (void)keyboardWillShow:(NSNotification *)note
{
    // 取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}
- (void)dealloc
{
    [IWNotificationCenter removeObserver:self];
}

- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    if(self.photosView.images.count)
    {
        [self sendWithImage];
    }
    else
    {
        [self sendWithoutImage];
    }
    // 关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendWithoutImage
{
    // AFNetWorking\AFN
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    params[@"access_token"] = [IWAccountTool account].access_token;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 7.隐藏提醒框
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 隐藏提醒框
        [MBProgressHUD showError:@"发送失败"];
    }];
}

- (void)sendWithImage
{
    // AFNetWorking\AFN
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    params[@"access_token"] = [IWAccountTool account].access_token;
    
    // 3.发送请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 在发送请求前调用这个block
        // 必须在这里说明要上传哪些文件
//        NSData *data = UIImageJPEGRepresentation(self.imageView.image, 0.5);
//        [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
        NSArray *images = self.photosView.images;
        for(UIImage *image in images)
        {
            NSData *data = UIImageJPEGRepresentation(image, 0.00001);
            [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 7.隐藏提醒框
        [MBProgressHUD showSuccess:@"发送成功"];
        IWLog(@"发送成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 隐藏提醒框
        [MBProgressHUD showError:@"发送失败"];
        IWLog(@"发送失败--%@", error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - toolbar的代理
- (void)composeToolbar:(IWComposeToolbar *)toolbar didClickButton:(IWComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case IWComposeToolbarButtonTypeCamera:
            [self openCamera];
            break;
        case IWComposeToolbarButtonTypePicture:
            [self openPhotoLibrary];
            break;
            
        default:
            break;
    }
}

- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)openPhotoLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - 图片选择控制器的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
