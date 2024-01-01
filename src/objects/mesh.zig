const math = @import("std").math;

const Color = @import("../primitives/color.zig").Color;
const Vector3 = @import("../primitives/vector3.zig").Vector3;
const Ray = @import("../primitives/ray.zig").Ray;
const Intersection = @import("../primitives/intersection.zig").Intersection;

pub const Mesh = struct {
    position: Vector3,
    color: Color,
    vertices: []Vector3,
    indicies: []i32,

    pub fn intersection(self: Mesh, ray: Ray, tMin: f64) Intersection
    {
        // Not implemented
        _ = ray;
        _ = tMin;

        return Intersection{
            .success = false,
            .normal = Vector3{.x = 0, .y = 0, .z = 0},
            .intersection = Vector3{.x = 0, .y = 0, .z = 0},
            .object = .{.mesh = self},
        };
    }
};