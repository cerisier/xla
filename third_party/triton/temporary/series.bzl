"""
Provides a list of temporary Triton patches.

These patches are expected to be short-lived and should be removed once
upstreamed or superseded.
"""

temporary_patch_list = [
    "//third_party/triton:temporary/triton_bazel_8.patch",
    # Add new patches just above this line. Format is "//third_party/triton:temporary/example.patch"
]
