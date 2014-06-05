//
//  ImageDownloader.h
//  PuushRipper
//
//  Created by Aaron Moss on 27/05/14.
//  Copyright (c) 2014 Aaron Moss. All rights reserved.
//
//  This class is designed to provide a relatively trivial way to randomize and download image links.
//  The puush method is a main method that uses the other methods to randomly download x puush images.

#import <Foundation/Foundation.h>

@interface ImageDownloader : NSObject

-(void) downloadImage: (NSString*) inputStringURL toFile: (NSString*) inputStringName;  //  Takes a String for the URL of the image to download and an String for the name of the image to save. It saves in the documents folder. 

-(NSMutableArray*) makePossibleValuesArray; //  Produces an array of valid possible link values from 0-9, A-Z, a-z

-(NSMutableString*) generatePuushUrlandName;    //  Generates a puush image URL and derived image name 

-(void) downloadPuushImage; //  Main method to download x puush images

@end
