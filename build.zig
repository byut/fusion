const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("fusion", .{
        .root_source_file = b.path("src/root.zig"),

        // .link_libc = true,
        // .link_libcpp = true,

        .target = target,
        .optimize = optimize,
    });

    const tests = b.addTest(.{
        .root_source_file = b.path("src/root.zig"),

        .target = target,
        .optimize = optimize,
    });
    // tests.linkLibC();
    // tests.linkLibCpp();

    b.installArtifact(tests);

    const run_tests = b.addRunArtifact(tests);
    run_tests.step.dependOn(b.getInstallStep());

    const test_step = b.step("test", "run unit tests");
    test_step.dependOn(&run_tests.step);
}
