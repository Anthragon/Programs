const std = @import("std");

pub fn stdout(content: []const u8) void {
    const stdout_req = Stdout1{
        .content = @intFromPtr(content),
        .length = content.len,
    };

    asm volatile (
        \\ syscall
        :
        : [num] "{rax}" (0x0000_0000),
          [req] "{rbx}" (&stdout_req),
        : .{ .rcx = true, .r11 = true, .memory = true });
}

const Stdout1 = extern struct {
    version: usize = 1,
    content: usize,
    length: usize,
};

const Stdout2 = extern struct {
    version: usize = 2,
    contentptr: usize,
};
