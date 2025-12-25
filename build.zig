const std = @import("std");
const builtin = @import("builtin");
const Target = std.Target;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const stdlib = b.addModule("stdlib", .{
        .root_source_file = b.path("stdlib/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const helloworld = b.addModule("helloworld", .{
        .root_source_file = b.path("helloworld/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    helloworld.addImport("stdlib", stdlib);

    const helloworld_exe = b.addExecutable(.{
        .name = "helloworld",
        .root_module = helloworld,
        .use_llvm = true,
    });
    const install_helloworld_exe = b.addInstallArtifact(helloworld_exe, .{});

    b.getInstallStep().dependOn(&install_helloworld_exe.step);
}
