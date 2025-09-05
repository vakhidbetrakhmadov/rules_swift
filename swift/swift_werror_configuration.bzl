# Copyright 2021 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Custom configuration to promote warnings into errors."""

load(":providers.bzl", "SwiftWerrorConfiguration")

def _swift_werror_configuration_impl(ctx):
    return SwiftWerrorConfiguration(
        ids = ctx.attr.ids,
        id_with_patterns = ctx.attr.id_with_patterns,
        no_id_patterns = ctx.attr.no_id_patterns,
    )

swift_werror_configuration = rule(
    attrs = {
        "ids": attr.string_list(
            default = [],
            doc = """\
`List` of strings. Contains warning diagnostic IDs. Warnings with these IDs will be
promoted to errors unconditionally.
""",
        ),
        "id_with_patterns": attr.string_list_dict(
            default = {},
            doc = """\
`Dict` mapping strings to lists of strings. Maps warning diagnostic IDs to multiple 
regex patterns. A warning message must match at least one of the corresponding 
patterns before it is promoted to an error.
""",
        ),
        "no_id_patterns": attr.string_list(
            default = [],
            doc = """\
`List` of strings. Contains regex patterns for warning messages that do not have a
diagnostic ID. These warnings will be promoted to errors if their message matches
one of the patterns.
"""
        ),
    },
    doc = """\
Configuration for promoting specific Swift compilation warnings to errors.
""",
    implementation = _swift_werror_configuration_impl,
)
