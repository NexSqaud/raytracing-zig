const Vector3 = @import("vector3.zig").Vector3;

pub const Ray = struct {
    origin: Vector3,
    direction: Vector3,

    pub fn at(self: Ray, t: f64) Vector3
    {
        return self.origin.add(self.direction.multiply(t));
    }
};
