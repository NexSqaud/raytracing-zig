 const math = @import("std").math;

pub const Vector3 = struct {
    x: f64 = 0.0,
    y: f64 = 0.0,
    z: f64 = 0.0,

    pub fn dot(self: Vector3, other: Vector3) f64 {
        return self.x * other.x + self.y * other.y + self.z * other.z;
    }

    pub fn cross(self: Vector3, other: Vector3) Vector3 {
        return Vector3{
            .x = self.y * other.z - self.z * other.y,
            .y = self.z * other.x - self.x * other.z,
            .z = self.x * other.y - self.y * other.x,
        };
    }

    pub fn lengthSquared(self: Vector3) f64 {
        return self.x * self.x + self.y * self.y + self.z * self.z;
    }

    pub fn length(self: Vector3) f64 {
        return math.sqrt(self.lengthSquared());
    }

    pub fn normalized(self: Vector3) Vector3 {
        return Vector3{
            .x = self.x / self.length(),
            .y = self.y / self.length(),
            .z = self.z / self.length(),
        };
    }

    pub fn reflect(self: Vector3, normal: Vector3) Vector3 {
        const normalDot = normal.dot(normal);
        return Vector3{
            .x = self.x - (normal.x * normalDot * 2),
            .y = self.y - (normal.y * normalDot * 2),
            .z = self.z - (normal.z * normalDot * 2),
        };
    }

    pub fn add(self: Vector3, other: Vector3) Vector3 {
        return Vector3{
            .x = self.x + other.x,
            .y = self.y + other.y,
            .z = self.z + other.z,
        };
    }

    pub fn substract(self: Vector3, other: Vector3) Vector3 {
        return Vector3{
            .x = self.x - other.x,
            .y = self.y - other.y,
            .z = self.z - other.z,
        };
    }

    pub fn multiply(self: Vector3, factor: f64) Vector3 {
        return Vector3{
            .x = self.x * factor,
            .y = self.y * factor,
            .z = self.z * factor,
        };
    }

    pub fn inverse(self: Vector3) Vector3
    {
        return Vector3{
            .x = -self.x,
            .y = -self.y,
            .z = -self.z
        };
    }
};
