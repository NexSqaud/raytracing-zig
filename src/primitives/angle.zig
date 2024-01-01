const std = @import("std");
const math = std.math;

pub const Angle = struct {
    radiansAngle: f64,

    pub fn fromDegrees(degrees: f64) Angle
    {
        return Angle
        {
            .radiansAngle = degrees / 180.0 * math.pi,
        };
    }

    pub fn fromRadians(radians: f64) Angle
    {
        return Angle
        {
            .radiansAngle = radians,
        };
    }

    pub fn getDegrees(self: Angle) f64
    {
        return self.radiansAngle / math.pi * 180.0;
    }

    pub fn getRadians(self: Angle) f64
    {
        return self.radiansAngle;
    }

    pub fn format(self: Angle, comptime _: []const u8, _: std.fmt.FormatOptions, writer: anytype) !void
    {
        _ = try writer.print("Angle (Radians: {}, Degrees: {})\n", .{self.getRadians(), self.getDegrees()});
    }
};
