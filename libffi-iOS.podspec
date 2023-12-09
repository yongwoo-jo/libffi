Pod::Spec.new do |spec|
  spec.name         = "libffi-iOS"
  spec.version      = "3.4.4-iOS"
  spec.summary      = "A portable foreign-function interface library."

  spec.description  = <<-DESC
                      Compilers for high level languages generate code that follow certain conventions. These conventions are necessary, in part, for separate compilation to work. One such convention is the "calling convention". The "calling convention" is essentially a set of assumptions made by the compiler about where function arguments will be found on entry to a function. A "calling convention" also specifies where the return value for a function is found.

Some programs may not know at the time of compilation what arguments are to be passed to a function. For instance, an interpreter may be told at run-time about the number and types of arguments used to call a given function. Libffi can be used in such programs to provide a bridge from the interpreter program to compiled code.

The libffi library provides a portable, high level programming interface to various calling conventions. This allows a programmer to call any function specified by a call interface description at run time.

FFI stands for Foreign Function Interface. A foreign function interface is the popular name for the interface that allows code written in one language to call code written in another language. The libffi library really only provides the lowest, machine dependent layer of a fully featured foreign function interface. A layer must exist above libffi that handles type conversions for values passed between the two languages.
                   DESC

  spec.homepage     = "https://github.com/623637646/libffi"
  spec.license      = "MIT"
  spec.author             = { "Yanni Wang 王氩" => "wy19900729@gmail.com" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/623637646/libffi.git", :tag => "v#{spec.version}" }
  spec.source_files  = "Sources/libffi-iOS/**/*.{h,c,S}"
  spec.public_header_files = "Sources/libffi-iOS/include/**/*.{h}"

  # `'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) USE_DL_PREFIX=1'` is for bug fixing of conflict with system free function. Otherwise encounter crash in unit tests, crash code is `if getMethodWithoutSearchingSuperClasses(targetClass: targetClass, selector: selector) == nil`. Reason is `Thread 1: signal SIGABRT`
  # `'DEFINES_MODULE' => 'YES'` is for avoid adding `:modular_headers => true` in podfile. Otherwise compile error: `Cannot load underlying module for 'libffi_iOS'` for static lib. Or encounter `pod install` error: The Swift pod `EasySwiftHook` depends upon `libffi-iOS`, which does not define modules. To opt into those targets generating module maps (which is necessary to import them from Swift when building as static libraries), you may set `use_modular_headers!` globally in your Podfile, or specify `:modular_headers => true` for particular dependencies.
  spec.pod_target_xcconfig = {'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) USE_DL_PREFIX=1', 'DEFINES_MODULE' => 'YES'}
end
