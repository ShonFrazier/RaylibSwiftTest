//
//  clay.c
//  Yokta Beginnings
//
//  Created by Shon on 2/6/25.
//

#define CLAY_IMPLEMENTATION 1
#include "clay.h"

Clay_ErrorHandler NO_HANDLER = { .errorHandlerFunction = NULL, .userData = NULL };

Clay_Arena Clay_Default_Initialize(Clay_Dimensions dimensions) {
  uint64_t clayRequiredMemory = Clay_MinMemorySize();
  Clay_Arena clayMemory = (Clay_Arena) {
    .memory = malloc(clayRequiredMemory),
    .capacity = clayRequiredMemory,
  };

  Clay_Initialize(clayMemory, dimensions, NO_HANDLER);

  return clayMemory;
}
