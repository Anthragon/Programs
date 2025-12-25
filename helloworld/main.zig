const std = @import("std");
const stdlib = @import("stdlib");

const std_options = stdlib.std_options;

pub fn main() !void {
    std.log.info("Hello, World!", .{});
    stdlib.suicide(0);
}
