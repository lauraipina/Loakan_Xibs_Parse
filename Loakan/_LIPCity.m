// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LIPCity.m instead.

#import "_LIPCity.h"

const struct LIPCityAttributes LIPCityAttributes = {
	.name = @"name",
};

const struct LIPCityRelationships LIPCityRelationships = {
	.markets = @"markets",
};

@implementation LIPCityID
@end

@implementation _LIPCity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"City";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"City" inManagedObjectContext:moc_];
}

- (LIPCityID*)objectID {
	return (LIPCityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic markets;

- (NSMutableSet*)marketsSet {
	[self willAccessValueForKey:@"markets"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"markets"];

	[self didAccessValueForKey:@"markets"];
	return result;
}

@end

