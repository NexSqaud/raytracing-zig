const std = @import("std");

const Color = @import("../primitives/color.zig").Color;
const Intersection = @import("../primitives/intersection.zig").Intersection;
const Ray = @import("../primitives/ray.zig").Ray;
const Sphere = @import("sphere.zig").Sphere;
const Mesh = @import("mesh.zig").Mesh;

pub const Object = union (enum) {
    sphere: Sphere,
    mesh: Mesh,

    pub fn initSphere(sphere: Sphere) Object
    {
        return Object{.sphere = sphere};
    }

    pub inline fn intersection(self: *const Object, ray: Ray, tMin: f64) Intersection
    {
        switch (self.*) 
        {
            Object.sphere => |sphere| return sphere.intersection(ray, tMin),
            Object.mesh => |mesh| return mesh.intersection(ray, tMin),
        }
        std.log.err("Object.intersection not implemented for {} type", .{@typeName(self.*)});
        unreachable;
    }

    pub inline fn getColor(self: *const Object) Color
    {
        switch (self.*) 
        {
            Object.sphere => |sphere| return sphere.color,
            Object.mesh => |mesh| return mesh.color,
        }
        std.log.err("Object.intersection not implemented for {} type", .{@typeName(self.*)});
        unreachable;
    }
};
