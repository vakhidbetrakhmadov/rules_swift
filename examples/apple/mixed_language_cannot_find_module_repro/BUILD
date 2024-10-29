load(
    "//swift:swift.bzl",
    "swift_library",
)
load(
    "//mixed_language:mixed_language_library.bzl",
    "mixed_language_library",
)

swift_library(
    name = "Renderer",
    module_name = "Renderer",
    srcs = [
        "Renderer.swift",
    ],
    generates_header = True,
)

swift_library(
    name = "Printer",
    module_name = "Printer",
    srcs = [
        "Printer.swift",
    ],
    deps = [
        ":Renderer",
    ],
    generates_header = True,
)

mixed_language_library(
    name = "Consumer",
    module_name = "Consumer",
    swift_srcs = [
        "HelloPrinter.swift",
    ],
    clang_srcs = [
        "Consumer.h",
        "Consumer.m",
    ],
    deps = [
        ":Printer",
    ],
    enable_modules = True,
)