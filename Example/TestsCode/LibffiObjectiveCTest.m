//
//  LibffiObjectiveCTest.m
//  CocoapodsDynamicLibExample
//
//  Created by Wang Ya on 7/12/23.
//

#import "LibffiObjectiveCTest.h"
#import <ffi.h>

// MARK: call

void testFFICallInObjectiveC(void)
{
    ffi_cif cif;
    ffi_type *args[1];
    void *values[1];
    char *s;
    ffi_arg rc;
    
    /* Initialize the argument info vectors */
    args[0] = &ffi_type_pointer;
    values[0] = &s;
    
    /* Initialize the cif */
    if (ffi_prep_cif(&cif, FFI_DEFAULT_ABI, 1,
                     &ffi_type_sint, args) == FFI_OK)
    {
        s = "Hello World!";
        ffi_call(&cif, (void (*)(void))puts, &rc, values);
        /* rc now holds the result of the call to puts */
        
        /* values holds a pointer to the function's arg, so to
         call puts() again all we need to do is change the
         value of s */
        s = "This is cool!";
        ffi_call(&cif, (void (*)(void))puts, &rc, values);
    }
}

// MARK: closure

/* Acts like puts with the file given at time of enclosure. */
void puts_binding(ffi_cif *cif, void *ret, void* args[],
                  void *stream)
{
    *(ffi_arg *)ret = fputs(*(char **)args[0], (FILE *)stream);
}

typedef int (*puts_t)(char *);

void testFFIClosureInObjeceiveC(void)
{
    ffi_cif cif;
    ffi_type *args[1];
    ffi_closure *closure;
    
    void *bound_puts;
    int rc;
    
    /* Allocate closure and bound_puts */
    closure = ffi_closure_alloc(sizeof(ffi_closure), &bound_puts);
    
    if (closure)
    {
        /* Initialize the argument info vectors */
        args[0] = &ffi_type_pointer;
        
        /* Initialize the cif */
        if (ffi_prep_cif(&cif, FFI_DEFAULT_ABI, 1,
                         &ffi_type_sint, args) == FFI_OK)
        {
            /* Initialize the closure, setting stream to stdout */
            if (ffi_prep_closure_loc(closure, &cif, puts_binding,
                                     stdout, bound_puts) == FFI_OK)
            {
                rc = ((puts_t)bound_puts)("Hello World!\n");
                /* rc now holds the result of the call to fputs */
            }
        }
    }
    
    /* Deallocate both closure, and bound_puts */
    ffi_closure_free(closure);
}
