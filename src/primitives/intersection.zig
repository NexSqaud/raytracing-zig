const inf = @import("std").math.inf;

const Object = @import("../objects/object.zig").Object;
const Vector3 = @import("vector3.zig").Vector3;

pub const Intersection = struct{
    success: bool = false,
    intersection: Vector3 = .{},
    normal: Vector3 = .{},
    object: Object,
    t: f64 = inf(f64),
};
