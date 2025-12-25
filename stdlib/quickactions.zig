pub fn suicide(exit_code: usize) noreturn {
    const suicide_req = Suicide{
        .exit_code = exit_code,
    };

    asm volatile (
        \\ syscall
        :
        : [num] "{rax}" (0x0000_0000),
          [req] "{rbx}" (&suicide_req),
        : .{ .rcx = true, .r11 = true, .memory = true });
    unreachable;
}

const Suicide = extern struct {
    version: usize = 1,
    exit_code: usize,
};
