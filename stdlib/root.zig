const std = @import("std");

pub const std_options: std.Options = .{ .logFn = logFn };

const quickactions = @import("quickactions.zig");
pub const debug = @import("debug.zig");

pub const suicide = quickactions.suicide;

fn logFn(
    comptime message_level: std.log.Level,
    comptime scope: @TypeOf(.enum_literal),
    comptime format: []const u8,
    args: anytype,
) void {
    var content_buf: [2048]u8 = undefined;

    const content = std.fmt.bufPrint(&content_buf, format, args) catch b: {
        const msg = "...[too long]\n";
        @memcpy(content_buf[2048 - msg.len ..], msg);
        break :b &content_buf;
    };

    debug.stdout(content);

    _ = message_level;
    _ = scope;
}
