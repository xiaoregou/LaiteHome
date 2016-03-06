//
//  AddNumberView.m
//  NewHome
//
//  Created by 小热狗 on 15/10/23.
//  Copyright © 2015年 小热狗. All rights reserved.
//

#import "AddNumberView.h"
#import "DatabaseOperation.h"
#define margin 10
@implementation AddNumberView

- (id)initWithFrame:(CGRect)frame buttonId:(long)btnId hostId:(long)hostId;//初始化
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self numberData:btnId];
        customSelect=NO;
      self.customSize=1;//默认大小
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(setCameraUid:) name: @"cameraUid" object: nil];
        
        long label_width;

        
        switch ( [UIDevice iPhonesModel]) {
            case iPhone4:
                textField_height=25.0;
                label_width=45;
                break;
            case iPhone5:
                textField_height=25.0;
                label_width=45;
                break;
            case iPhone6:
                textField_height=30.0;
                label_width=60;
                break;
            case iPhone6Plus:
                textField_height=30.0;
                label_width=60;
                break;
            case UnKnown:
                textField_height=50.0;
                label_width=60;
                break;
                
                
            default:
                break;
        }
        

        
        
        long btn_width=frame.size.width/4;
        long btn_height=frame.size.height/6;
                

        long contentView_height=frame.size.height-2*btn_height;  //内容高度
        long padding=(contentView_height-5*textField_height)/6;//y间距
        
        
        long padding1=(contentView_height-4*textField_height)/5;//y间距
        float img_height=contentView_height-4*padding1;//标题长度
        float img_width=img_height*539/425;
        float imgY=(contentView_height-img_height)/2+btn_height;

               long textfield_width=frame.size.width-label_width-img_width-4*margin;   //输入框长度
        
        
        
        //标题栏
        UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, btn_height)];
        titleView.backgroundColor=PopView_TitleColor;
        
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(btn_width/6, 5, 2*btn_width, btn_height-10)];
        titleLabel.text=@"数值";
        titleLabel.textColor=[UIColor colorWithRed:92.0/255.0 green:170.0/255.0 blue:247.0/255.0 alpha:1];
        [titleView addSubview:titleLabel];
        
        [self addSubview:titleView];
        
        
        
        
        
        
        
        CGFloat btnName_Y=CGRectGetMaxY(titleView.frame)+padding;
        UIImageView *cameraView=[[UIImageView alloc]initWithFrame:CGRectMake(margin, imgY, img_width, img_height)];
        cameraView.image=[UIImage imageNamed:@"ic_number_feed"];
        [self addSubview:cameraView];
        
        CGFloat carmeraName_x=CGRectGetMaxX(cameraView.frame)+margin;
        UILabel *carmeraName=[[UILabel alloc]initWithFrame:CGRectMake(carmeraName_x, btnName_Y, label_width, textField_height)];
        carmeraName.text=@"名称";
        carmeraName.textColor=Text_color;
        [self addSubview:carmeraName];
        
        CGFloat uid_y=CGRectGetMaxY(carmeraName.frame)+padding;
        UILabel *carmeraUid=[[UILabel alloc]initWithFrame:CGRectMake(carmeraName_x, uid_y, label_width, textField_height)];
        carmeraUid.text=@"地址";
        carmeraUid.textColor=Text_color;
        [self addSubview:carmeraUid];
        
        CGFloat carmeraUsername_y=CGRectGetMaxY(carmeraUid.frame)+padding;
        UILabel *carmeraUsername=[[UILabel alloc]initWithFrame:CGRectMake(carmeraName_x, carmeraUsername_y, label_width, textField_height)];
        carmeraUsername.text=@"数值一";
        carmeraUsername.textColor=Text_color;
        [self addSubview:carmeraUsername];
        
        CGFloat carmeraPassword_y=CGRectGetMaxY(carmeraUsername.frame)+padding;
        UILabel *carmeraPassword=[[UILabel alloc]initWithFrame:CGRectMake(carmeraName_x, carmeraPassword_y, label_width, textField_height)];
        carmeraPassword.text=@"数值二";
        carmeraPassword.textColor=Text_color;
        [self addSubview:carmeraPassword];
        
        
        CGFloat carmeraNameText_x=CGRectGetMaxX(carmeraName.frame)+margin;
        carmeraNameText=[[UITextField alloc]initWithFrame:CGRectMake(carmeraNameText_x, btnName_Y, textfield_width, textField_height)];
        carmeraNameText.backgroundColor=BACKGROUND_COLOR;
      carmeraNameText.text=modal.numberName;
        carmeraNameText.placeholder=@"名称";

        //imeiText.text=hostInterFace.host_network;
        carmeraNameText.delegate=self;
        [self addSubview:carmeraNameText];
        
        
        CGFloat carmeraUidText_y=CGRectGetMaxY(carmeraNameText.frame)+padding;
        carmeraUidText=[[UITextField alloc]initWithFrame:CGRectMake(carmeraNameText_x, carmeraUidText_y, textfield_width, textField_height)];
        carmeraUidText.backgroundColor=BACKGROUND_COLOR;
          carmeraUidText.placeholder=@"地址";
        carmeraUidText.text=modal.numberAddr;
        // imeiText.text=hostInterFace.host_network;
        carmeraUidText.delegate=self;
        [self addSubview:carmeraUidText];
        
//        CGFloat scanBtn_x=CGRectGetMaxX(carmeraUidText.frame)+10;
//        UIButton *scanBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//        scanBtn.frame=CGRectMake(scanBtn_x, carmeraUidText_y, textfield_width/3-10,TextField_height);
//        [scanBtn setTitle:@"扫描" forState:UIControlStateNormal];
//        scanBtn.backgroundColor=[UIColor blueColor];
//        [scanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [scanBtn addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:scanBtn];
        
        CGFloat carmeraUserName_y=CGRectGetMaxY(carmeraUidText.frame)+padding;
        carmeraUserNameText=[[UITextField alloc]initWithFrame:CGRectMake(carmeraNameText_x, carmeraUserName_y, textfield_width, textField_height)];
        carmeraUserNameText.backgroundColor=BACKGROUND_COLOR;
          carmeraUserNameText.placeholder=@"数值一";
        carmeraUserNameText.text=modal.numberOne;
        // imeiText.text=hostInterFace.host_network;
        carmeraUserNameText.delegate=self;
        [self addSubview:carmeraUserNameText];
        
        
        CGFloat carmeraPassWordText_y=CGRectGetMaxY(carmeraUserNameText.frame)+padding;
        carmeraPassWordText=[[UITextField alloc]initWithFrame:CGRectMake(carmeraNameText_x, carmeraPassWordText_y, textfield_width, textField_height)];
        carmeraPassWordText.backgroundColor=BACKGROUND_COLOR;
        carmeraPassWordText.placeholder=@"数值二";
        carmeraPassWordText.text=modal.numberTwo;
        //imeiText.text=hostInterFace.host_network;
        carmeraPassWordText.delegate=self;
        [self addSubview:carmeraPassWordText];
        
        
        
        
        
        CGFloat sizeLabel_Y= CGRectGetMaxY(carmeraPassword.frame)+padding;
        UILabel *sizeLabel=[[UILabel alloc]initWithFrame:CGRectMake(carmeraName_x, sizeLabel_Y,label_width, textField_height)];
        sizeLabel.text=@"宽高";
        sizeLabel.textColor=Text_color;
        
        [self addSubview:sizeLabel];
        
        CGFloat sizeBtn_X=CGRectGetMaxX(sizeLabel.frame)+margin;
        sizeBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        sizeBtn.frame=CGRectMake(sizeBtn_X, sizeLabel.frame.origin.y+textField_height/4, textField_height/2, textField_height/2);
        sizeBtn.backgroundColor=[UIColor clearColor];
        [sizeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sizeBtn.tintColor=[UIColor clearColor];
        [sizeBtn setBackgroundImage:[UIImage imageNamed:@"方框选中"] forState:UIControlStateSelected];
        [sizeBtn setBackgroundImage:[UIImage imageNamed:@"未标题-1"] forState:UIControlStateNormal];
        [sizeBtn addTarget:self action:@selector(sizeBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sizeBtn];
        
        CGFloat widthText_X=CGRectGetMaxX(sizeBtn.frame)+margin;
        widthText=[[UITextField alloc]initWithFrame:CGRectMake(widthText_X,sizeLabel.frame.origin.y, label_width, textField_height)];
         widthText.textColor=[UIColor lightGrayColor];
                if (modal.customSelect==2) {
                    long btnWidth=modal.width;
                    widthText.text=[NSString stringWithFormat:@"%0ld",btnWidth];
                    self.customSize=2;
                    sizeBtn.selected=YES;
        
                    widthText.enabled=YES;
        
                }else{
                    widthText.text=@"200";
              widthText.enabled=NO;
                }
        
        
        widthText.backgroundColor=BACKGROUND_COLOR;
        
        widthText.keyboardType= UIKeyboardTypeNumberPad;
        [self addSubview:widthText];
        
        CGFloat heightText_X=CGRectGetMaxX(widthText.frame)+margin;
        heightText=[[UITextField alloc]initWithFrame:CGRectMake(heightText_X,sizeLabel.frame.origin.y, label_width, textField_height)];
         heightText.textColor=[UIColor lightGrayColor];
                if (modal.customSelect==2) {
                    long btnHeight=modal.height;
                    heightText.text=[NSString stringWithFormat:@"%ld",btnHeight];
                    self.customSize=2;
                    sizeBtn.selected=YES;
        
                    heightText.enabled=YES;
        
                }else{
                    heightText.text=@"85";
                heightText.enabled=NO;
                }
        
        
       
        heightText.backgroundColor=BACKGROUND_COLOR;
        heightText.keyboardType= UIKeyboardTypeNumberPad;
        [self addSubview:heightText];
        
        
        
        UIButton *cancelBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelBtn.frame=CGRectMake(0, frame.size.height-btn_height, frame.size.width*2/3, btn_height);
        cancelBtn.backgroundColor=[UIColor clearColor];
        cancelBtn.tag=1;
        [cancelBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        //[cancelBtn setBackgroundImage:[UIImage imageNamed:@"确认选中-1"] forState:UIControlStateSelected];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(addNumberClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UIButton *okBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        okBtn.frame=CGRectMake(frame.size.width*2/3, cancelBtn.frame.origin.y, frame.size.width/3, btn_height);
        okBtn.backgroundColor=[UIColor clearColor];
        okBtn.tag=2;
        [okBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        //[okBtn setBackgroundImage:[UIImage imageNamed:@"确认选中-1"] forState:UIControlStateSelected];
        [okBtn setBackgroundImage:[UIImage imageNamed:@"确认选中-1"] forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(addNumberClick:) forControlEvents:UIControlEventTouchUpInside];
        [okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self addSubview:okBtn];
        
        
        
        
    }
    return self;
}

-(void)sizeBtnSelect:(UIButton *)sender{
    
    if (sender.selected==YES) {
        
        sender.selected=NO;
        self.customSize=1; //默认
        widthText.enabled=NO;
        heightText.enabled=NO;
        
    }else{
        
        sender.selected=YES;
        self.customSize=2;//自定义
        widthText.enabled=YES;
        heightText.enabled=YES;
    }
    
    
    
    
    
}

-(void)numberData:(long)numberId{
    
    modal=[NumberModal new];
    
    modal=[DatabaseOperation queryNumber:numberId];
   
    
}
-(void)addNumberClick:(UIButton *)sender{
    
    if (self.customSize==1) {
        widthText.text=@"150";
        heightText.text=@"50";
        
        [self.delegate addNumber:carmeraNameText.text numberAddr:carmeraUidText.text numberOne:carmeraUserNameText.text tag:sender.tag numberTwo:carmeraPassWordText.text width:widthText.text height:heightText.text customSelect:self.customSize];
        
    }else{
        
        
        if ([widthText.text isEqualToString:@""]||[heightText.text isEqualToString:@""]) {
            NSString *message=@"按钮宽高不能为空";
            [self makeToast:message];
            return;
        }else if ([widthText.text isEqualToString:@"0"]||[heightText.text isEqualToString:@"0"]) {
            NSString *message=@"按钮宽高不能为0";
            [self makeToast:message];
            return;
        }else{
            [self.delegate addNumber:carmeraNameText.text numberAddr:carmeraUidText.text numberOne:carmeraUserNameText.text tag:sender.tag numberTwo:carmeraPassWordText.text width:widthText.text height:heightText.text customSelect:self.customSize];
        }
        
        
        
        
        
        
        
    }

   
}
@end
