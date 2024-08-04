pub fn connectSetup(conn: common.ConnectResult, fixed: *x.ConnectSetup.Fixed) void {
    inline for (@typeInfo(@TypeOf(fixed.*)).Struct.fields) |field| {
        std.log.debug("{s}: {any}", .{ field.name, @field(fixed, field.name) });
    }
    const vendor_slice = conn.setup.getVendorSlice(fixed.vendor_len) catch return;
    std.log.debug("vendor: {s}", .{vendor_slice});
}

pub fn formatList(conn: common.ConnectResult, offset: u32, limit: u32) void {
    std.log.debug("fmt list off={} limit={}", .{ offset, limit });
    const formats = conn.setup.getFormatList(offset, limit) catch return;
    for (formats, 0..) |format, i| {
        std.log.debug("format[{}] depth={:3} bpp={:3} scanpad={:3}", .{
            i,
            format.depth,
            format.bits_per_pixel,
            format.scanline_pad,
        });
    }
}

pub fn screenProperties(screen: *x.Screen) void {
    inline for (@typeInfo(@TypeOf(screen.*)).Struct.fields) |field| {
        std.log.debug("SCREEN 0| {s}: {any}", .{ field.name, @field(screen, field.name) });
    }
}

const builtin = @import("builtin");
const std = @import("std");
const x = @import("x");
const common = @import("common.zig");
