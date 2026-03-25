# load("@llvm//:cuda.bzl", _cuda_library = "cuda_library")
load("@local_config_cuda//cuda:build_defs.bzl", _cuda_library = "cuda_library")
load("@rules_cc//cc:cc_library.bzl", "cc_library")

def cuda_library(name, copts = [],defines = [], additional_compiler_inputs = [], **kwargs):
    _cuda_library(
        name = name,
        copts = copts + [
            "--cuda-path=$(location {})".format(Label("//:cuda_path")),
        ],
        additional_compiler_inputs = additional_compiler_inputs + [
            Label("//:cuda_path"),
        ],
        defines = defines + [
            "_ALLOW_UNSUPPORTED_LIBCPP",
        ],
        **kwargs,
)

def cuda_library2(name, **kwargs):

    defines = kwargs.pop("defines", []) + [
        "_ALLOW_UNSUPPORTED_LIBCPP",
    ]

    deps = kwargs.pop("deps", []) + [
        "@local_config_cuda//cuda:implicit_cuda_headers_dependency",
        # "@cuda//cuda:cuda_headers",
        # "@cuda//crt:headers",
        # "@cuda//cudart:headers",
        # "@cuda//curand:headers",
    ]

    cc_library(
        name = name,
        copts = kwargs.pop("copts", []) + [
            "--cuda-path=$(location @llvm//toolchain/cuda:current_cuda_path)",
            "-x", "cuda",
            "--cuda-gpu-arch=sm_80",
        ],
        additional_compiler_inputs = kwargs.pop("additional_compiler_inputs", []) + [
            "@llvm//toolchain/cuda:current_cuda_path",
        ],
        deps = deps,
        defines = defines,
        **kwargs,
)
