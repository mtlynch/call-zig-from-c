const std = @import("std");
const c_void = @TypeOf(undefined);

const evmc = @cImport({
    @cInclude("evmc.h");
});
const testing = std.testing;

export fn add(a: i32, b: i32) i32 {
    return a + b + evmc.EVMC_FAILURE;
}

fn execute(
    _: [*c]evmc.evmc_vm,
    _: [*c]const evmc.evmc_host_interface,
    _: ?*evmc.evmc_host_context,
    _: evmc.evmc_revision,
    _: [*c]const evmc.evmc_message,
    _: [*c]const u8,
    _: usize,
) callconv(.C) evmc.evmc_result {
    return evmc.evmc_result{
        .status_code = evmc.EVMC_SUCCESS,
        .gas_left = 0,
        .gas_refund = 0,
        .output_data = null,
        .output_size = 0,
        .release = null,
        .create_address = evmc.evmc_address{
            .bytes = [20]u8{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        },
        .padding = [4]u8{ 0, 0, 0, 0 },
    };
}

fn get_capabilities(_: [*c]evmc.evmc_vm) callconv(.C) evmc.evmc_capabilities_flagset {
    return 0;
}

fn destroy(_: [*c]evmc.evmc_vm) callconv(.C) void {
    return;
}

export fn evmc_create_example_vm() *evmc.evmc_vm {
    var vm: evmc.evmc_vm = evmc.evmc_vm{
        .abi_version = evmc.EVMC_ABI_VERSION,
        .name = "dummy name",
        .version = "0.0.1",
        .execute = &execute,
        .get_capabilities = &get_capabilities,
        .set_option = null,
        .destroy = &destroy,
    };
    return &vm;
}

test "basic add functionality" {
    try testing.expectEqual(add(3, 7), 10);
}
