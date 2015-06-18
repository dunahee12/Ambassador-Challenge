//
//  Link.h
//  
//
//  Created by Jacob Dunahee on 6/17/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Link : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * openCount;

@end
