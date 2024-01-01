const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});


    const exe = b.addExecutable(.{
        .name = "raytracing-zig",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const zigimg = b.dependency("zigimg", .{
        .target = target,
        .optimize = optimize,
    });

    exe.addModule("zigimg", zigimg.module("zigimg"));

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const test_step = b.step("test", "Run unit tests");
    const unit_tests = b.addTest(. {
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
    });

    const run_tests = b.addRunArtifact(unit_tests);
    test_step.dependOn(&run_tests.step);

    const run_step = b.step("run", "Run app");
    const run = b.addRunArtifact(exe);
    run_step.dependOn(&run.step);

    if(b.args) |args|
    {
        run.addArgs(args);
    }
}
