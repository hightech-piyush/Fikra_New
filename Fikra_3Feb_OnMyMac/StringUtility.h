//
//  StringUtility.h
//  BamTech
//
//  Created by Manjit Bhuriya on 26/02/13.
//
//

#import <Foundation/Foundation.h>
#

@interface StringUtility : NSObject

+ (BOOL ) stringIsEmpty:(NSString *) aString;
+ (BOOL ) stringIsEmpty:(NSString *) aString shouldCleanWhiteSpace:(BOOL)cleanWhileSpace;
+ (BOOL ) stringIsEmptyContainingNullObject:(NSString *) string;
+ (NSString *) stringShouldCleanAndRemoveWhiteSpace:(NSString *) cleanString;
+(NSString *)checkNullInString:(NSString *)string;
+(NSString *)trimWhiteSpaceAndNewLine:(NSString *)string;
+ (float)setDynamicHeightForString:(NSString *)sourceString withFont:(UIFont *)font;
+ (float)setDynamicKeyHeightForString:(NSString *)sourceString withFont:(UIFont *)font;
+ (float)setDynamicPartListHeightForString:(NSString *)sourceString withFont:(UIFont *)font;
+ (NSString *)XIBNameAsPerDevice:(NSString *)stringXibName;
+(void) setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners;
+ (float)setDynamicSizeForString:(NSString *)sourceString withFont:(UIFont *)font withSize:(CGSize)size;
+ (float)setDynamicWidthForString:(NSString *)sourceString withFont:(UIFont *)font withSize:(CGSize)size;
+(NSString *)getCurrentTimeStamp;
+(BOOL)iPhoneRetina;
+(NSString *) replaceStringForUpdate:(NSString *) inputString;
+(NSString *)appendCurrentDateToTime:(NSString *)strTime;
+(NSString *)stripDateFromDateTime:(NSString *)strDateTime;
+(NSString *)getOnlyTimeFromGivenDateTime:(NSDate *)date;
+(NSDate *)convertStringToDate:(NSString *)strDate;
+(NSDate *)convertDateAndRemoveSeconds:(NSDate *)date;
+(NSString *)convertDateToString:(NSDate *)date;
+(NSString *)getOnlyDateComponentFromString:(NSString *)strDate;
+(NSString *)appendCurrentTimeToGivenDateString:(NSString *)strDate;
+(NSString *)getOnlyDateComponentFromDate:(NSDate *)date;
+ (BOOL)validateUSZipCodes:(NSString*)zipCode;
+ (BOOL)validateEmailWithString:(NSString*)email;
+ (BOOL)validateNumericValues:(NSString*)number;
+ (BOOL)validateAlphaNumericValues:(NSString*)alphanum;

+(NSString *)parseJSONBreakersForString:(NSString *)sourceString;
+(NSString *)getCurrentTimeStampInMMddYYYY;
+ (BOOL)validateCANADAZipCodes:(NSString*)zipCode;
+(NSDate *)convertStringToFullDate:(NSString *)strDate;
+(NSString *)convertDateToStringMMddYYYYhhmmss:(NSDate *)date;
+(BOOL)validateUSSSN:(NSString*)zipCode;
+(BOOL)validateCanadaSSN:(NSString*)zipCode;
@end
