//
// Created by Manuele Mion on 10/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <Foundation/Foundation.h>

static inline CGFloat LLMConvertKelvinToCelsiusDegree(CGFloat degreeInKelvin) {
    return (degreeInKelvin - 273.15);
}