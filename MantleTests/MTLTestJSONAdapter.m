//
//  MTLTestJSONAdapter.m
//  Mantle
//
//  Created by Robert Böhnke on 03/04/14.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

#import "MTLTestJSONAdapter.h"
#import "MTLTestModel.h"

@implementation MTLTestJSONAdapter

- (NSSet *)serializablePropertyKeys:(NSSet *)propertyKeys forModel:(id<MTLJSONSerializing>)model {
	NSMutableSet *copy = [propertyKeys mutableCopy];

	[copy minusSet:self.ignoredPropertyKeys];

	return copy;
}

- (NSDictionary *)JSONDictionaryFromModel:(id<MTLJSONSerializing>)model error:(NSError **)error {
	NSDictionary *dictionary = [super JSONDictionaryFromModel:model error:error];
	return [dictionary mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"test": @YES
	}];
}


@end

@implementation MTLJSONAdapter (custom)


+(NSValueTransformer *)defaultTransformerForClass:(Class)modelClass propertyType:(const char *)propertyType propertyKey:(NSString *)propertyKey
{
	NSLog(@"xxxxx [%@ %@] %s", NSStringFromClass(modelClass), propertyKey, propertyType);
	
	return nil;
}

+(NSDictionary *)adjustJSONDictionary:(NSDictionary *)JSONDictionary beforeToModelClass:(Class)modelClass
{
	if ([modelClass isSubclassOfClass:MTLAdjustModel.class]) {
		JSONDictionary = @{@"name": @"Changed"};
	}
	return JSONDictionary;
}

@end
