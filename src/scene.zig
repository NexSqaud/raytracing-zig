const ArrayList = @import("std").ArrayList;

const Camera = @import("camera.zig").Camera;
const Object = @import("objects/object.zig").Object;
const Lamp = @import("objects/lamp.zig").Lamp;

pub const Scene = struct
{
    camera: Camera,
    objects: ArrayList(Object),
    lamps: ArrayList(Lamp),
};
