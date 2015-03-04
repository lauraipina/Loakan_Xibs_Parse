// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LIPMarket.m instead.

#import "_LIPMarket.h"

const struct LIPMarketAttributes LIPMarketAttributes = {
	.facebook = @"facebook",
	.favorite = @"favorite",
	.info = @"info",
	.instagram = @"instagram",
	.name = @"name",
	.timetable = @"timetable",
	.twitter = @"twitter",
	.web = @"web",
};

const struct LIPMarketRelationships LIPMarketRelationships = {
	.address = @"address",
	.city = @"city",
	.photo = @"photo",
};

@implementation LIPMarketID
@end

@implementation _LIPMarket

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Market" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Market";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Market" inManagedObjectContext:moc_];
}

- (LIPMarketID*)objectID {
	return (LIPMarketID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"favoriteValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"favorite"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic facebook;

@dynamic favorite;

- (BOOL)favoriteValue {
	NSNumber *result = [self favorite];
	return [result boolValue];
}

- (void)setFavoriteValue:(BOOL)value_ {
	[self setFavorite:@(value_)];
}

- (BOOL)primitiveFavoriteValue {
	NSNumber *result = [self primitiveFavorite];
	return [result boolValue];
}

- (void)setPrimitiveFavoriteValue:(BOOL)value_ {
	[self setPrimitiveFavorite:@(value_)];
}

@dynamic info;

@dynamic instagram;

@dynamic name;

@dynamic timetable;

@dynamic twitter;

@dynamic web;

@dynamic address;

@dynamic city;

@dynamic photo;

@end

