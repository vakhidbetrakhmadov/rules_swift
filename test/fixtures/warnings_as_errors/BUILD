load("//mixed_language:mixed_language_library.bzl", "mixed_language_library")
load(
    "//swift:swift_library.bzl",
    "swift_library",
)
load("//swift:swift_werror_configuration.bzl", "swift_werror_configuration")
load("//test/fixtures:common.bzl", "FIXTURE_TAGS")

package(
    default_visibility = ["//test:__subpackages__"],
)

licenses(["notice"])

###############################################################################
# Fixtures for testing warnings-as-errors features.

swift_library(
    name = "legacy_diagnostic_id",
    srcs = ["Empty.swift"],
    features = [
        "swift.werror.access_control_ext_member_more",
    ],
    tags = FIXTURE_TAGS,
)

swift_library(
    name = "warning_group",
    srcs = ["Empty.swift"],
    features = [
        "swift.werror.DeprecatedDeclaration",
    ],
    tags = FIXTURE_TAGS,
)

swift_library(
    name = "mixed_diagnostic_and_group",
    srcs = ["Empty.swift"],
    features = [
        "swift.werror.access_control_ext_member_more",
        "swift.werror.DeprecatedDeclaration",
    ],
    tags = FIXTURE_TAGS,
)

swift_library(
    name = "disabled_features",
    srcs = ["Empty.swift"],
    features = [
        "-swift.werror.access_control_ext_member_more",
        "-swift.werror.DeprecatedDeclaration",
    ],
    tags = FIXTURE_TAGS,
)

swift_library(
    name = "empty_name",
    srcs = ["Empty.swift"],
    features = ["swift.werror."],
    tags = FIXTURE_TAGS,
)

swift_library(
    name = "split_warning_groups",
    srcs = ["Empty.swift"],
    features = [
        "swift.split_derived_files_generation",
        "swift.werror.DeprecatedDeclaration",
        "swift.werror.UnusedResult",
    ],
    tags = FIXTURE_TAGS,
)

swift_werror_configuration(
    name = "custom_configuration",
    id_with_patterns = {"filtered_id": ["selected message"]},
    ids = ["chosen_id"],
    no_id_patterns = ["unidentified message"],
)

swift_library(
    name = "custom_configuration_library",
    srcs = ["Empty.swift"],
    features = [
        "swift.split_derived_files_generation",
        "swift.werror.DeprecatedDeclaration",
    ],
    tags = FIXTURE_TAGS,
    werror_configuration = ":custom_configuration",
)

mixed_language_library(
    name = "mixed_custom_configuration",
    hdrs = ["Empty.h"],
    clang_srcs = [],
    swift_srcs = ["Empty.swift"],
    swift_werror_configuration = ":custom_configuration",
    tags = FIXTURE_TAGS,
)
