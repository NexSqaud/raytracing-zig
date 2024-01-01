const math = @import("std").math;

const Color = @import("../primitives/color.zig").Color;
const Vector3 = @import("../primitives/vector3.zig").Vector3;
const Ray = @import("../primitives/ray.zig").Ray;
const Intersection = @import("../primitives/intersection.zig").Intersection;

pub const Sphere = struct
{
    position: Vector3,
    color: Color,
    radius: f64,

    pub fn intersection(self: Sphere, ray: Ray, tMin: f64) Intersection
    {
        const originToCenter = ray.origin.substract(self.position);

        const a = ray.direction.dot(ray.direction);
        const b = 2.0 * originToCenter.dot(ray.direction);
        const c = originToCenter.dot(originToCenter) - (self.radius * self.radius);

        const d = (b * b) - (4 * (a * c));

        if(d < 0)
        {
            return .{.object = .{.sphere = self}};
        }

        const t1 = (-b + math.sqrt(d)) / (2 * a);
        const t2 = (-b - math.sqrt(d)) / (2 * a);

        var t = math.inf(f64);
        if(t1 > tMin) t = t1;
        if(t2 < t1 and t2 > tMin) t = t2;

        return Intersection{
            .success = t != math.inf(f64),
            .intersection = ray.at(t),
            .normal = ray.at(t).substract(self.position).normalized(),
            .object = .{.sphere = self},
            .t = t,
        };
    }
};
