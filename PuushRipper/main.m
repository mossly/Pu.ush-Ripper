//
//  main.m
//  PuushRipper
//
//  Created by Aaron Moss on 27/05/14.
//  Copyright (c) 2014 Aaron Moss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloader.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool 
    {
        ImageDownloader *myImageDownloader = [[ImageDownloader alloc] init];    //  Creates a new instance of the image downloader class
        
        [myImageDownloader downloadPuushImage]; //  Runs the main method
        
        NSLog(@"End");  //  Prints end at the end of the program
    }    
    
    return 0;
}