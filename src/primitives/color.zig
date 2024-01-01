const std = @import("std");

pub const Color = struct {
    r: u8 = 255,
    g: u8 = 255,
    b: u8 = 255,

    pub fn multiply(self: Color, factor: f64) Color
    {
        const clampedFactor = std.math.clamp(factor, 0.0, 1.0);

        return Color{
            .r = @as(u8, @intFromFloat(@as(f64, @floatFromInt(self.r)) * clampedFactor)),
            .g = @as(u8, @intFromFloat(@as(f64, @floatFromInt(self.g)) * clampedFactor)),
            .b = @as(u8, @intFromFloat(@as(f64, @floatFromInt(self.b)) * clampedFactor)),
        };
    }
};
