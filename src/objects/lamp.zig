const Vector3 = @import("../primitives/vector3.zig").Vector3;

pub const Lamp = struct{
    position: Vector3,
    intensity: f64,
};