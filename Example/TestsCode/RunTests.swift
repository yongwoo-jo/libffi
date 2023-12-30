//
//  RunTests.swift
//  CocoapodsDynamicLibExample
//
//  Created by Wang Ya on 7/12/23.
//

import Foundation

func runTest(){
    print(">>>>>> call function in objective-c")
    testFFICallInObjectiveC()
    print("")
    print(">>>>>> call function in swift")
    testFFICallInSwift()
    print("")
    print(">>>>>> call closure in objective-c")
    testFFIClosureInObjeceiveC()
    print("")
    print(">>>>>> call closure in swift")
    testFFIClosureInSwift()
}
