//
//  GetAllFuncList.m
//  GetAllFuncList
//
//  Created by 尹现伟 on 15-1-16.
//  Copyright (c) 2015年 DNE Technology Co.,Ltd. All rights reserved.
//

#import "GetAllFuncList.h"

@implementation GetAllFuncList

static NSMutableString *__text = nil;

+ (NSString *)openWithPath:(NSString *)path{
    
    __text = [NSMutableString string];

    
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    NSArray *files = [fileManage subpathsOfDirectoryAtPath: path error:nil];
    
    files = [self getClassPathInAry:files inPath:path];
    
    for(NSString *path in files){
        const char * a =[path UTF8String];
        
        checkFile(a);
    }
    
    return __text;
}


+ (NSArray *)getClassPathInAry:(NSArray *)ary inPath:(NSString *)inPath{
    NSMutableArray *pathArray = [NSMutableArray array];
    for(NSString *path in ary){
        NSString *fileType = [path pathExtension];
        if([fileType isEqualToString:@"h"]){
            
            NSFileManager *fileManager = [[NSFileManager alloc]init];
            NSString *file = [NSString stringWithFormat:@"%@.m",[inPath stringByAppendingPathComponent:[path stringByDeletingPathExtension]]];
            if ([fileManager fileExistsAtPath:file]) {
                [pathArray addObject:[inPath stringByAppendingPathComponent:path]];
            }
        }
    }
    return pathArray;
}



int findMethod(char *text)
{
    char *p = text;
    char c;
    while((c = *p++) !='\n'){
        if (c == '-' || c=='+') {
            if( ((*p == ' ' && *(p + 1) == '(') || *p == '(' )){
                if( text[0] == '-' || (text[0] == '+'))
                {
                    print_Method(text);
                }
            }
        }
    }
    return 0;
}


int checkFile(const char *filepath)
{
    //printf("＝＝＝＝%s", filepath);
    FILE *fp1;//定义文件流指针，用于打开读取的文件
    char text[10241];//定义一个字符串数组，用于存储读取的字符
    fp1 = fopen(filepath,"r");//只读方式打开文件a.txt
    while(fgets(text,10240,fp1)!=NULL)//逐行读取fp1所指向文件中的内容到text中
    {
        //puts(text);//输出到屏幕
        findMethod(text);
    }
    fclose(fp1);//关闭文件a.txt，有打开就要有关闭
    
    return 0;
}


int print_Method(char *text)
{
    char *p = text;
    char c;
    int start = 0;
    while((c = *p++) !='\n'){//Method
        if(c == ':' || c == '{' || c == ';'){
            start = 0;
            break;
        }
        if(start == 1){
            printf("%c", c);
            [__text appendFormat:@"%c",c];
        }
        if(c == ')')
            start = 1;
    }
    printf("\n");
    [__text appendFormat:@"%@",@"\n"];
    start = 0;
    while((c = *p++) !='\n'){//arge
        if(c == ':'){
            start = 0;
            printf("\n");
            [__text appendFormat:@"%@",@"\n"];
        }
        if(start == 2 && c != '{'){
            printf("%c", c);
            [__text appendFormat:@"%c",c];
        }
        if(c == ' ' && start == 1)
            start = 2;
        if(c == ')')
            start = 1;
    }
    //printf("\n");
    
    return 0;
}



@end
