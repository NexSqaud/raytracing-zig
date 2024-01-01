const vector3 = @import("primitives/vector3.zig");

const Angle = @import("primitives/angle.zig").Angle;
const Ray = @import("primitives/ray.zig").Ray;
const Vector3 = vector3.Vector3;

pub const Camera = struct {
    position: Vector3,
    direction: Vector3,
    deltaU: Vector3,
    deltaV: Vector3,
    upperLeft: Vector3,

    pub fn init(position: Vector3, lookAt: Vector3, aspectRatio: f64) Camera
    {
        const direction = lookAt.substract(position).normalized();

        const focalLength = 1.0;
        const viewportHeight = 2.0;
        const viewportWidth = viewportHeight * aspectRatio;

        const viewportU = Vector3{.x = viewportWidth};
        const viewportV = Vector3{.y = -viewportHeight};

        return Camera{
            .position = position,
            .direction = direction,
            .deltaU = viewportU,
            .deltaV = viewportV,
            .upperLeft = position.substract(Vector3{.z = focalLength})
                            .substract(viewportU.multiply(0.5))
                            .substract(viewportV.multiply(0.5)),
        };
    }

    pub fn getRay(self: Camera, x: f64, y: f64) Ray
    {
        const center = self.upperLeft.add(self.deltaU.multiply(x)).add(self.deltaV.multiply(y));
        const direction = center.substract(self.position);

        return Ray{
            .origin = center,
            .direction = direction
        };
    }
};
