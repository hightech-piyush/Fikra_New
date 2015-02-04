//
//  StringUtility.m
//  BamTech
//
//  Created by Manjit Bhuriya on 26/02/13.
//
//

#import "StringUtility.h"

@implementation StringUtility


+ (BOOL) stringIsEmpty:(NSString *) aString {
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL ) stringIsEmpty:(NSString *) aString shouldCleanWhiteSpace:(BOOL)cleanWhileSpace {
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    }
    
    if (cleanWhileSpace) {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL ) stringIsEmptyContainingNullObject:(NSString *) string {
    NSString *strFormat = [NSString stringWithFormat:@"%@",string];
    if ([strFormat isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}


+ (float)setDynamicHeightForString:(NSString *)sourceString withFont:(UIFont *)font{
    NSString *sourceStr = [NSString stringWithFormat:@"%@",sourceString];
    if ([sourceStr isEqualToString:@"(null)"]) {
        sourceStr = @"";
    }
    if ([sourceStr isEqualToString:@"<null>"]) {
        sourceStr = @"";
        
    }
    if ([sourceStr isEqualToString:@"<nil>"]) {
        sourceStr = @"";
    }
    if ([sourceStr isKindOfClass:[NSNull class]]) {
        sourceStr = @"";
    }
    if ([sourceStr isEqualToString:nil]) {
        sourceStr = @"";
    }
    if (sourceStr == nil) {
        sourceStr = @"";
    }
    NSString *stringFinal = [sourceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    float heightValue = [stringFinal sizeWithFont:font constrainedToSize:CGSizeMake(140, 999999) lineBreakMode:NSLineBreakByWordWrapping].height;
    
    return heightValue;
}

+ (NSString *) stringShouldCleanAndRemoveWhiteSpace:(NSString *) cleanString{
    NSString *strCleanString = [cleanString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return strCleanString;
}

+(NSString *)trimWhiteSpaceAndNewLine:(NSString *)string
{
    NSString *stringSource = [NSString stringWithFormat:@"%@",string];
    if ([stringSource isEqualToString:@"(null)"]) {
        stringSource = @"";
        return stringSource;
    }
    if ([stringSource isEqualToString:@"<null>"]) {
        stringSource = @"";
        return stringSource;
    }
    if ([stringSource isEqualToString:@"<nil>"]) {
        stringSource = @"";
        return stringSource;
    }
    if ([stringSource isKindOfClass:[NSNull class]]) {
        stringSource = @"";
        return stringSource;
    }
    if ([stringSource isEqualToString:nil]) {
        stringSource = @"";
        return stringSource;
    }
    if (stringSource == nil) {
        stringSource = @"";
        return stringSource;
    }
    NSString *stringFinal = [stringSource stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return stringFinal;
    
}

+(NSString *)checkNullInString:(NSString *)string
{
    NSString *strValue;
    
    NSString *strFinal = [NSString stringWithFormat:@"%@",string];
    
    if([strFinal isEqualToString:@"(null)"] || [strFinal isEqualToString:@"<null>"] || [strFinal isKindOfClass:[NSNull class]])
    {
        strValue = @"";
    }
    else
    {
        strValue = strFinal;
    }
    return strValue;
}

//127
+ (float)setDynamicKeyHeightForString:(NSString *)sourceString withFont:(UIFont *)font{
    NSString *sourceStr = [NSString stringWithFormat:@"%@",sourceString];
    if ([sourceStr isEqualToString:@"(null)"]) {
        sourceStr = @"";
    }
    if ([sourceStr isEqualToString:@"<null>"]) {
        sourceStr = @"";
        
    }
    if ([sourceStr isEqualToString:@"<nil>"]) {
        sourceStr = @"";
    }
    if ([sourceStr isKindOfClass:[NSNull class]]) {
        sourceStr = @"";
    }
    if ([sourceStr isEqualToString:nil]) {
        sourceStr = @"";
    }
    if (sourceStr == nil) {
        sourceStr = @"";
    }
    NSString *stringFinal = [sourceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    float heightValue = [stringFinal sizeWithFont:font constrainedToSize:CGSizeMake(127, 999999) lineBreakMode:NSLineBreakByWordWrapping].height;
    
    return heightValue;
}

+ (float)setDynamicPartListHeightForString:(NSString *)sourceString withFont:(UIFont *)font{
    NSString *sourceStr = [NSString stringWithFormat:@"%@",sourceString];
    if ([sourceStr isEqualToString:@"(null)"]) {
        sourceStr = @"";
    }
    if ([sourceStr isEqualToString:@"<null>"]) {
        sourceStr = @"";
        
    }
    if ([sourceStr isEqualToString:@"<nil>"]) {
        sourceStr = @"";
    }
    if ([sourceStr isKindOfClass:[NSNull class]]) {
        sourceStr = @"";
    }
    if ([sourceStr isEqualToString:nil]) {
        sourceStr = @"";
    }
    if (sourceStr == nil) {
        sourceStr = @"";
    }
    NSString *stringFinal = [sourceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    float heightValue = [stringFinal sizeWithFont:font constrainedToSize:CGSizeMake(270, 999999) lineBreakMode:NSLineBreakByWordWrapping].height;
    
    return heightValue;
}

+ (float)setDynamicSizeForString:(NSString *)sourceString withFont:(UIFont *)font withSize:(CGSize)size{
    NSString *sourceStr = [NSString stringWithFormat:@"%@",sourceString];
    if ([sourceStr isEqualToString:@"(null)"]) {
        sourceStr = @"";
    }
    if ([sourceStr isEqualToString:@"<null>"]) {
        sourceStr = @"";
        
    }
    if ([sourceStr isEqualToString:@"<nil>"]) {
        sourceStr = @"";
    }
    if ([sourceStr isKindOfClass:[NSNull class]]) {
        sourceStr = @"";
    }
    if ([sourceStr isEqualToString:nil]) {
        sourceStr = @"";
    }
    if (sourceStr == nil) {
        sourceStr = @"";
    }
    NSString *stringFinal = [sourceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    float heightValue = [stringFinal sizeWithFont:font constrainedToSize:CGSizeMake(270, 999999) lineBreakMode:NSLineBreakByWordWrapping].height;
    
    return heightValue;
}

+ (float)setDynamicWidthForString:(NSString *)sourceString withFont:(UIFont *)font withSize:(CGSize)size{
    NSString *sourceStr = [NSString stringWithFormat:@"%@",sourceString];
    if ([sourceStr isEqualToString:@"(null)"]) {
        sourceStr = @"";
    }
    if ([sourceStr isEqualToString:@"<null>"]) {
        sourceStr = @"";
        
    }
    if ([sourceStr isEqualToString:@"<nil>"]) {
        sourceStr = @"";
    }
    if ([sourceStr isKindOfClass:[NSNull class]]) {
        sourceStr = @"";
    }
    if ([sourceStr isEqualToString:nil]) {
        sourceStr = @"";
    }
    if (sourceStr == nil) {
        sourceStr = @"";
    }
    NSString *stringFinal = [sourceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    float widthValue = [stringFinal sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping].width;
    
    return widthValue;
}

+(void) setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(9.0, 9.0)];
    
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    view.layer.mask = shape;
}

+(NSString *)getCurrentTimeStamp
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *strDate = [dateformatter stringFromDate:date];
    NSLog(@"strDate: %@",strDate);
    return strDate;
}

+(BOOL)iPhoneRetina{
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))?1:0;
}

+(NSString *) replaceStringForUpdate:(NSString *) inputString {
    NSString *strInputString = [NSString stringWithFormat:@"%@",inputString];
    

    strInputString = [strInputString stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    strInputString = [strInputString stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    strInputString = [strInputString stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    strInputString = [strInputString stringByReplacingOccurrencesOfString:@"'" withString:@"﻿﻿﻿﻿﻿&#39;"];
    return strInputString;
}

+(NSString *)appendCurrentDateToTime:(NSString *)strTime
{
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"hh:mm:ss aaa"];
    NSDate *tempDate = [timeFormat dateFromString:strTime];
    [timeFormat setDateFormat:@"hh:mm aaa"];
    NSString *strTempTime = [timeFormat stringFromDate:tempDate];
    [timeFormat setDateFormat:@"hh:mm aaa"];
    NSDate *finalDate = [timeFormat dateFromString:strTempTime];
    [timeFormat setDateFormat:@"hh:mm:ss aaa"];
    NSString *strTimeFinal = [timeFormat stringFromDate:finalDate];
    
    NSLog(@"strTime: %@",strTimeFinal);
    NSString *strDateFinal = @"";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    strDateFinal = [dateFormat stringFromDate:[NSDate date]];
    
    NSString *stringFinal = [NSString stringWithFormat:@"%@ %@",[StringUtility trimWhiteSpaceAndNewLine:strDateFinal],[StringUtility trimWhiteSpaceAndNewLine:strTimeFinal]];

    return stringFinal;
}

+(NSString *)stripDateFromDateTime:(NSString *)strDateTime
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy hh:mm:ss aaa"];
    NSDate *dateTime = [dateFormat dateFromString:strDateTime];
    [dateFormat setDateFormat:@"hh:mm:ss aaa"];
    NSString *stringTime = [dateFormat stringFromDate:dateTime];
    return stringTime;
}

+(NSString *)getOnlyTimeFromGivenDateTime:(NSDate *)date
{
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"hh:mm:ss aaa"];
    NSString *strTime = [timeFormat stringFromDate:date];
    [timeFormat setDateFormat:@"hh:mm:ss aaa"];
    NSDate *tempDate = [timeFormat dateFromString:strTime];
    [timeFormat setDateFormat:@"hh:mm aaa"];
    NSString *strTempTime = [timeFormat stringFromDate:tempDate];
    [timeFormat setDateFormat:@"hh:mm aaa"];
    NSDate *finalDate = [timeFormat dateFromString:strTempTime];
    [timeFormat setDateFormat:@"hh:mm:ss aaa"];
    NSString *strTimeFinal = [timeFormat stringFromDate:finalDate];
    
    NSLog(@"strTime: %@",strTimeFinal);
    return strTimeFinal;
}

+(NSDate *)convertStringToDate:(NSString *)strDate
{
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"MM/dd/yyyy hh:mm:ss aaa"];
    NSDate *date = [timeFormat dateFromString:strDate];
    [timeFormat setDateFormat:@"MM/dd/yyyy hh:mm aaa"];
    NSString *strDateFinal = [timeFormat stringFromDate:date];
    [timeFormat setDateFormat:@"MM/dd/yyyy hh:mm aaa"];
    NSDate *dateFinal = [timeFormat dateFromString:strDateFinal];
    return dateFinal;
}

+(NSDate *)convertDateAndRemoveSeconds:(NSDate *)date
{
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"MM/dd/yyyy hh:mm aaa"];
    NSString *strDate = [timeFormat stringFromDate:date];
    [timeFormat setDateFormat:@"MM/dd/yyyy hh:mm aaa"];
    NSDate *dateFinal = [timeFormat dateFromString:strDate];
    return dateFinal;
}

+(NSString *)convertDateToString:(NSDate *)date
{
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"MM/dd/yyyy hh:mm:ss aaa"];
    NSString *strDate = [timeFormat stringFromDate:date];
    return strDate;
}

+(NSDate *)convertStringToFullDate:(NSString *)strDate
{
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"MM/dd/yyyy hh:mm:ss aaa"];
    NSDate *date = [timeFormat dateFromString:strDate];
    return date;
}

+(NSString *)convertDateToStringMMddYYYYhhmmss:(NSDate *)date
{
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"MM/dd/yyyy hh:mm:ss aaa"];
    NSString *strDate = [timeFormat stringFromDate:date];
    return strDate;
}

+(NSString *)getOnlyDateComponentFromDate:(NSDate *)date
{
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"MM/dd/yyyy"];
    NSString *strdate = [timeFormat stringFromDate:date];
    return strdate;
}


+(NSString *)getOnlyDateComponentFromString:(NSString *)strDate
{
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"MM/dd/yyyy hh:mm:ss aaa"];
    NSDate *date = [timeFormat dateFromString:strDate];
    [timeFormat setDateFormat:@"MM/dd/yyyy"];
    NSString *strDateFinal = [timeFormat stringFromDate:date];
    return strDateFinal;
}

+(NSString *)appendCurrentTimeToGivenDateString:(NSString *)strDate
{
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"hh:mm:ss aaa"];
    NSString *strTime = [timeFormat stringFromDate:[NSDate date]];
    
    NSString *stringFinal = [NSString stringWithFormat:@"%@ %@",[StringUtility trimWhiteSpaceAndNewLine:strDate],[StringUtility trimWhiteSpaceAndNewLine:strTime]];
    return stringFinal;
}

+ (BOOL)validateAlphaNumericValues:(NSString*)alphanum {
    NSString *alphanumRegex = @"/^[0-9]|([0-9]+[a-zA-Z]+|[a-zA-Z]+[0-9]+)[0-9a-zA-Z]*$/";
    NSPredicate *alphanumTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", alphanumRegex];
    return [alphanumTest evaluateWithObject:alphanum];
}

+ (BOOL)validateNumericValues:(NSString*)number {
    NSString *numRegex = @"^\\d+$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
    return [numTest evaluateWithObject:number];
}

+ (BOOL)validateUSZipCodes:(NSString*)zipCode {
    NSString *zipRegex = @"^\\d{5}(-\\d{4})?$";
    NSPredicate *zipTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zipRegex];
    return [zipTest evaluateWithObject:zipCode];
}

+ (BOOL)validateCANADAZipCodes:(NSString*)zipCode {
    NSString *zipRegex = @"^[ABCEGHJKLMNPRSTVXY]{1}\\d{1}[A-Z]{1} *\\d{1}[A-Z]{1}\\d{1}$";
    NSPredicate *zipTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zipRegex];
    return [zipTest evaluateWithObject:zipCode];
}

+ (BOOL)validateEmailWithString:(NSString*)email {
    if([email length]>0)
    {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        return [emailTest evaluateWithObject:email];
    }
    else
    {
        return YES;
    }
}



+(NSString *)parseJSONBreakersForString:(NSString *)sourceString
{
    NSString *strResponse = @"";
    strResponse = [sourceString stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    strResponse = [sourceString stringByReplacingOccurrencesOfString:@"/" withString:@"\\/"];
    strResponse = [strResponse stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    strResponse = [strResponse stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    return strResponse;
}

+(NSString *)getCurrentTimeStampInMMddYYYY
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM/dd/yyyy hh:mm aaa"];
    NSString *strDate = [dateformatter stringFromDate:date];
    NSDate *dateHHMM = [dateformatter dateFromString:strDate];
    [dateformatter setDateFormat:@"MM/dd/yyyy hh:mm:ss aaa"];
     NSString *strDateFinal = [dateformatter stringFromDate:dateHHMM];
    NSLog(@"strDate: %@",strDateFinal);
    return strDateFinal;
}

+(BOOL)validateUSSSN:(NSString*)zipCode {
    NSString *zipRegex = @"^(\\d{3}-\\d{2}-\\d{4}|XXX-XX-XXXX)$";
    NSPredicate *zipTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zipRegex];
    return [zipTest evaluateWithObject:zipCode];
}

+(BOOL)validateCanadaSSN:(NSString*)zipCode {
    NSString *zipRegex = @"^(\\d{3}-\\d{3}-\\d{3}|XXX-XXX-XXX)$";
    NSPredicate *zipTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zipRegex];
    return [zipTest evaluateWithObject:zipCode];
}

@end
