//
//  ImageDownloader.m
//  PuushRipper
//
//  Created by Aaron Moss on 27/05/14.
//  Copyright (c) 2014 Aaron Moss. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

-(void) downloadImage: (NSMutableString*) inputStringURL toFile: (NSMutableString*) inputStringName;
{
    
    NSMutableString *imgURL = [[NSMutableString alloc] initWithString:inputStringURL];    //  Local string to store the inputted image URL
    [imgURL appendFormat:@".png"];  //  Appends the image file type .png
    NSLog(@"%@", imgURL);   //  Outputs image URL to console
    
    NSString *imgName = inputStringName;    //  Local string to store the inputted image name

    
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];  //  String that gets and stores the documents path
    
    NSFileManager *fileManager = [NSFileManager defaultManager];    //  New file manager to handle downloading images
    NSString *writablePath = [documentsDirectoryPath stringByAppendingPathComponent:imgName];   //  Creates a writable path by appending the documents path with the image name
    
    if(![fileManager fileExistsAtPath:writablePath])    //  Checks for file duplication
    {
        NSLog(@"file doesn't exist");   //  File doesn't exist
        
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString: imgURL]];   //  Save Image From URL
        
        NSError *error = nil;   //  Error to check for error during file writing
        [data writeToFile:[documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", imgName]] options:NSAtomicWrite error:&error];   //  Writes the retrieved image from image url to the writiable path
        
        if (error)  //  Checks for error
        {
            NSLog(@"Error Writing File : %@",error);    //  Error occurs
        }
        else
        {
            NSLog(@"Image %@ Saved SuccessFully",imgName);  //  Error does not occur
        }
    }
    
    else
    {
        NSLog(@"file exist");   //  File exists
    }

}

-(NSMutableArray*) makePossibleValuesArray;
{
    NSMutableArray *values = [NSMutableArray new]; //  Array to store 62 valid Ascii values
    
    //  Loop Variable Declarations
    int c1 = 0; //  Loop Variable
    int decStart = 48;  //  Start of decimals in Ascii
    int decLimit = 57;  //  End of decimals in Ascii
    
    int upperCaseStart = 65;    //  Start of uppercase alphabet in Ascii
    int upperCaseLimit = 90;    //  End of uppercase alphabet in Ascii
    
    int lowerCasestart = 97;    //  Start of lowercase alphabet in Ascii
    int lowerCaseLimit = 122;   //  End of lowercase alphabet in Ascii

    int loopStart = decStart;   //  Loop lower start
    int loopLimit = decLimit;   //  Loop upper limit
    c1 = loopStart; //  Loop allocated for loop start
    
    for (c1 = loopStart; c1 <= loopLimit; c1++) //  Loop cycles through Ascii 0-9, A-Z, a-z, as integer codes
    {
        NSNumber *numberc1 = [NSNumber numberWithInt:c1];   //  Saves the current Ascii integer code as an NSNumber
        
        [values addObject: numberc1];   //  Adds the NSNumber to the values array
        
        if (c1 == loopLimit)    //  If the loop Variable hits the upper limit
        {
            if (c1 == decLimit) //  If it's the decimal limit
            {
                c1 = (upperCaseStart - 1);  //  The loop Variable should skip to the start of uppercase
                loopLimit = upperCaseLimit; //  The loop limit should now be the uppercase limit
            }
            
            if (c1 == upperCaseLimit)   //  If it's the uppercase limit
            {
                c1 = (lowerCasestart);  //  The loop Variable should skip to the start of lowercase
                loopLimit = lowerCaseLimit; //  The loop limit should now be the lowercase limit
            }
        }
        
    }
    return values;  //  Returns the array of values
}

-(NSMutableArray*) generatePuushUrlandName;
{
    NSMutableString * imgURL = [NSMutableString new];   //  Variable to store the URL of the image
    NSMutableString * imgName = [NSMutableString new];  //  Variable to store the name of the image
    
        NSMutableArray *possibleValues = [[NSMutableArray alloc] initWithArray:[self makePossibleValuesArray]]; //  Array of possible values created by calling the method
        NSMutableArray *digitValues = [NSMutableArray new]; //  Array to store 15 randomized values from the 62 possible values
        
        for (int i = 0; i < 15; i++)    //  Loop runs 15 times
        {
            int r = arc4random() % 61;  //  Generates random number from 0 to 61
            NSNumber * number = possibleValues[r];  //  The random number is used to access a random value from the possible values array, which is stored in an NSNumber
            [digitValues addObject: number];    //  The NSNumber is added to the array of randomized values
        }
    
        [imgName appendFormat:@"Pu.ush image "];    //  Prepares the image name by adding a description
        [imgURL appendFormat:@"http://puu.sh/"];    //  Prepares the image URL by adding the sites prefix
        
        for (int i = 0; i < 15; i++)    //  Loop runs 15 times
        {
            int number = [digitValues[i] intValue]; //  Integer from the NSNumber in the values array
            
            [imgName appendFormat:@"%c", number];   //  Appends the integer as a character (Ascii) to the image name
            [imgURL appendFormat:@"%c", number];    //  ...and the image URL
            
            if ( i == 4 )   //  Once we've reached the fifth character, we need to introduce the split
            {
                [imgURL appendFormat:@"/"]; //  Appends a / for the URL
                [imgName appendFormat:@","];    //  Appends a , for the Name, as / would lead to a new directory
            }
        }
    
        [imgName appendFormat:@".png"]; //  Appends file format to the image name so it can be opened in finder
    
        NSMutableArray * returnStrings = [NSMutableArray new];  //  Creates an array to return the two string from a single method
        [returnStrings addObject:imgURL];   //  Adds the first string to the array
        [returnStrings addObject:imgName];  //  Adds the second string to the array
    
    return returnStrings;   //  Returns the array of two strings
}

-(void) downloadPuushImage;
{
    int numbImagestoDownload;   //  An integer to store the target number of images the user wants to download
    NSLog(@"Enter number of images to aim for");    //  Prompts the user to enter value for variable
    scanf ("%i", &numbImagestoDownload);    //  User input, integer value for variable
    
    int i = 0;  //  Loop variable
    while ( i < numbImagestoDownload )  //  Loop runs until the amount of images the user requested have been downloaded.
    {
        NSMutableArray *returnedArray = [self generatePuushUrlandName]; //  Local array to store the returned array of the Image URL and Image Name from the method
        
        [self downloadImage: returnedArray[0] toFile: returnedArray[1]];    //  Calls the download method using the image URL and Image Name from the local Array
        
        NSMutableString *createdFilePath = [NSMutableString new];   //  String to store the path of the downloaded file 
        [createdFilePath appendFormat: @"/Users/Mossly/Documents/"];    //  Appends to the string the documents directory.
        [createdFilePath appendFormat: returnedArray[1]];   //  Appends to the string the image name
        
        unsigned long long fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:createdFilePath error:nil] fileSize]; //  Checks the size of the file at the created file path
        
        NSLog(@"%lli", fileSize);   //  Prints the size of the file
        
        if (fileSize == 0 || fileSize == 42)    //  Checks if the file is junk: either 0bytes (Doesn't Exist), or if the file is 42bytes (No permission to see)
        {
            [[NSFileManager defaultManager] removeItemAtPath:createdFilePath error:nil];    //  Removes the file if it is a junk file
        }
        else
        {
            i++;    //  If the file is downloaded correctly then the loop increments, otherwise it doesn't
        }
        
    }
}

@end
