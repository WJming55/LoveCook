//
//  EditViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "EditViewController.h"
#import "Factory.h"
#import "UMSocial.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface EditViewController ()<UIActionSheetDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UIButton *sexButton;
- (IBAction)sexButtonClik:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *addText;
@property (weak, nonatomic) IBOutlet UITextView *sumText;
- (IBAction)ToExit:(id)sender;

- (IBAction)selectPhoto:(id)sender;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createRiteButton];
    [self initData];
}
-(void)initData{
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
    self.nameText.text=self.name;
    [self.sexButton setTitle:self.sex forState:UIControlStateNormal];
    self.addText.text=self.add;
}
-(void)createRiteButton{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(Todone)];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor orangeColor];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor orangeColor];
}
-(void)Todone{

}
- (IBAction)sexButtonClik:(id)sender {
}

//  退出登录
- (IBAction)ToExit:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要退出吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle=UIAlertViewStyleDefault;
    [alert show];

}

- (IBAction)selectPhoto:(id)sender {
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"请选择照片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"照相机", nil];
    actionSheet.actionSheetStyle=UIActionSheetStyleAutomatic;
    [actionSheet showInView:self.view];
}
//活动切片代理函数
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {//相册
        //判断是否支持相册  UIImagePickerControllerSourceTypePhotoLibrary
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            //加载相册
            [self loadImagePickerControllerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"不支持相册" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
    }else if (buttonIndex==1){
        //判断是否支持拍照  UIImagePickerControllerSourceTypePhotoLibrary
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            //加载拍照 功能
            [self loadImagePickerControllerWithType:UIImagePickerControllerSourceTypeCamera];
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"相机不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }
}

- (void)loadImagePickerControllerWithType:(UIImagePickerControllerSourceType)type{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.sourceType=type;
    imagePicker.delegate=self;
    imagePicker.allowsEditing=YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

//警示框代理函数
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        AppDelegate *applction=[UIApplication sharedApplication].delegate;
        [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
            // NSLog(@"response is %@",response);
            applction.token=nil;
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}
//相册代理函数   放弃
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *sourceType=info[UIImagePickerControllerMediaType];
    
    if ([sourceType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image=info[UIImagePickerControllerOriginalImage];
        self.imageView1.image=image;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.nameText resignFirstResponder];
    [self.sumText resignFirstResponder];
    [self.addText resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end























