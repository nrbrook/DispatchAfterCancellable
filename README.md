# Introduction

The built in dispatch after function does not allow the call to be cancelled. This prevents the block being called if cancelled through the use of tokens.

## Installation

Add the swift file to your project

## Usage

```swift
let t = DispatchQueue.main.asyncAfterC(deadline: DispatchTime(timeIntervalSinceNow: 10), execute: { 
    print("Executed 1")
})

// cancel

DispatchQueue.asyncAfterCCancel(token: t)
```
