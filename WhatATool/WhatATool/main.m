//
//  main.m
//  WhatATool
//
//  Created by mobile on 3/15/16.
//  Copyright (c) 2016 McMaster-Carr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PolygonShape.h"

// sample function for one section, use a similar function per section
void PrintPathInfo() {
    // Code from path info section here
    NSString *path = @"~";
    path = path.stringByExpandingTildeInPath;
    NSLog(@"My home folder is at %@",path);
}

void PrintProcessInfo(){
    NSString *processName = [[NSProcessInfo processInfo] processName];
    int processId = [[NSProcessInfo processInfo] processIdentifier];
    NSLog(@"The process name is %@ with an id of %d",processName,processId);
}

void PrintBookmarkInfo(){
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:3];
    [dict setObject:[NSURL URLWithString:@"http://www.stanford.edu"] forKey:@"Stanford University"];
    [dict setObject:[NSURL URLWithString:@"http://www.apple.com"] forKey:@"Apple"];
    [dict setObject:[NSURL URLWithString:@"http://stanfordshop.com"] forKey:@"Stanford Mail"];

    for (id key in dict) {
        if ([key hasPrefix:@"Stanford"]) {
            NSLog(@"This one is prefixed with Stanford for key: %@ and url: %@",key,[dict valueForKey:key]);
        } else {
            NSLog(@"This one is NOT prefixed with Stanford for key: %@ and url: %@",key,[dict valueForKey:key]);
        }
    }
}

void DoPolygonStuff(){
    PolygonShape *poly = [[PolygonShape alloc] initWithNumberOfSides:80 minimumNumberOfSides:1 maximumNumberOfSides:11];
    
    NSLog(@"polygon has %d sides",poly.numberOfSides);
}

int main (int argc, const char * argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    PrintPathInfo();
    PrintProcessInfo();
    PrintBookmarkInfo();
    DoPolygonStuff();
    //PrintIntrospectionInfo();  // Section 4
    [pool release];
    return 0;
}
