//
//  UIImage+Watermark.m
//  mn_tools
//
//  Created by xhl on 2021/8/5.
//

#import "UIImage+Watermark.h"

@implementation UIImage (Watermark)

- (UIImage *)syncImageWithUrl:(NSString *)url{
    
    NSData *dataStr = [url dataUsingEncoding:NSUTF8StringEncoding];
    NSString * pathBase64 =  [dataStr base64EncodedStringWithOptions:0];;//url名字加密
    
    //获取图片的路径
    NSString * path = NSHomeDirectory();
    NSString * name = [NSString stringWithFormat:@"/Library/%@.png",pathBase64];
    NSString * filePath = [path stringByAppendingString:name];
    //取缓存的图片
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:filePath];
    
    if (!image) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        image = [UIImage imageWithData:data];
        BOOL result = [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]; // 保存成功会返回YES
        NSLog(@"缓存：%@",(result ? @"成功":@"失败"));
    }else{
        NSLog(@"用了缓存图片策略：%@",filePath);
    }
    return image;
   
}

- (UIImage *)addWatermarkWithWaterImageSource:(id)waterImageSource
                                     location:(WaterImageLocation)location
                                    waterSize:(float)waterSize{
    
    UIImage *waterImage;
    if ([waterImageSource isKindOfClass:NSString.class]) {
        waterImage = [self syncImageWithUrl:waterImageSource];
    }else if ([waterImageSource isKindOfClass:UIImage.class]) {
        waterImage = waterImageSource;
    }
    
    UIGraphicsBeginImageContext(self.size);
    
    // 原始图片渲染
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    if (waterSize >1 || waterSize <= 0) {
        waterSize = 1;
    }
    CGFloat waterX = 0;
    CGFloat waterY = 0;
    CGFloat waterW = self.size.width *waterSize;
    CGFloat waterH = waterImage.size.height * waterW/waterImage.size.width;
    
    if (location == WaterImageLocationTopCenter) {
        waterX = self.size.width/2 - waterW/2;
    }else if (location == WaterImageLocationTopRight) {
        waterX = self.size.width - waterW;
    }
    
    else if (location == WaterImageLocationCenterLeft) {
        waterY = self.size.height/2 - waterH/2;
    }else if (location == WaterImageLocationCenter) {
        waterX = self.size.width/2 - waterW/2;
        waterY = self.size.height/2 - waterH/2;
    }else if (location == WaterImageLocationCenterRight) {
        waterX = self.size.width - waterW;
        waterY = self.size.height/2 - waterH/2;
    }
    
    else if (location == WaterImageLocationBottomLeft) {
        waterY = self.size.height - waterH;
    }else if (location == WaterImageLocationBottomCenter) {
        waterX = self.size.width/2 - waterW/2;
        waterY = self.size.height - waterH;
    }else if (location == WaterImageLocationBottomRight) {
        waterX = self.size.width - waterW;
        waterY = self.size.height - waterH;
    }

    
    CGRect waterRect = CGRectMake(waterX, waterY, waterW, waterH);

    // 打入的水印图片 渲染
    [waterImage drawInRect:waterRect];
    
    // 打入的水印的文字渲 染
//    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//
//    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
//
//    NSDictionary * dic = @{
//                           NSFontAttributeName : [UIFont systemFontOfSize:40],
//                           NSParagraphStyleAttributeName : paragraphStyle,
//                           NSForegroundColorAttributeName : [UIColor redColor]
//                           };
//
//    [waterString drawInRect:CGRectMake(50, 50, 200, 50) withAttributes:dic];
    
    UIGraphicsEndPDFContext();
    // UIImage
    UIImage * imageNew = UIGraphicsGetImageFromCurrentImageContext();
    return imageNew;
}

@end
