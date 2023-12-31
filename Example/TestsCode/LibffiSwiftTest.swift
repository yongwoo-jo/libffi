//
//  LibffiSwiftTest.swift
//  CocoapodsDynamicLibExample
//
//  Created by Wang Ya on 7/12/23.
//

import Foundation
import libffi_apple

// MARK: call

private let targetFuntion = {
    print("Target function is called in Swift")
} as @convention(c) () -> Void

func testFFICallInSwift() {
    var cif: ffi_cif = ffi_cif()
    withUnsafeMutablePointer(to: &cif) { cifPointer in
        guard (ffi_prep_cif(
            cifPointer,
            FFI_DEFAULT_ABI,
            UInt32(0),
            UnsafeMutablePointer(&ffi_type_void),
            nil)) == FFI_OK else {
            assertionFailure()
            return
        }
        ffi_call(cifPointer, targetFuntion, nil, nil)
    }
}

// MARK: closure

private let targetFunctionBinding = { cif, ret, arges, userdata in
    ffi_call(cif, targetFuntion, ret, arges)
} as @convention(c) (_ cif: UnsafeMutablePointer<ffi_cif>?, _ ret: UnsafeMutableRawPointer?, _ args: UnsafeMutablePointer<UnsafeMutableRawPointer?>?, _ userdata: UnsafeMutableRawPointer?) -> Void

func testFFIClosureInSwift() {
    var cif: ffi_cif = ffi_cif()
    withUnsafeMutablePointer(to: &cif) { cifPointer in
        guard (ffi_prep_cif(
            cifPointer,
            FFI_DEFAULT_ABI,
            UInt32(0),
            UnsafeMutablePointer(&ffi_type_void),
            nil)) == FFI_OK else {
            assertionFailure()
            return
        }
        
        var boundTargetFunctionPointer: UnsafeMutableRawPointer?
        let closurePointer = withUnsafeMutablePointer(to: &boundTargetFunctionPointer) { boundTargetFunctionPointerPointer in
            ffi_closure_alloc(MemoryLayout<ffi_closure>.stride, boundTargetFunctionPointerPointer).assumingMemoryBound(to: ffi_closure.self)
        }
        guard let boundTargetFunctionPointer else {
            assertionFailure()
            return
        }
        guard (ffi_prep_closure_loc(
            closurePointer,
            cifPointer,
            targetFunctionBinding,
            nil,
            boundTargetFunctionPointer)) == FFI_OK else {
            assertionFailure()
            return
        }
        let closure: @convention(c) () -> Void = unsafeBitCast(boundTargetFunctionPointer, to: (@convention(c) () -> Void).self)
        closure()
        /* Deallocate both closure, and bound_puts */
        ffi_closure_free(closurePointer);
    }
}
