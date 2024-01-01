const std = @import("std");
const zigimg = @import("zigimg");

const ArrayList = std.ArrayList;
const Camera = @import("camera.zig").Camera;
const Scene = @import("scene.zig").Scene;

const Lamp = @import("objects/lamp.zig").Lamp;
const Object = @import("objects/object.zig").Object;
const Sphere = @import("objects/sphere.zig").Sphere;
const Mesh = @import("objects/mesh.zig").Mesh;

const Color = @import("primitives/color.zig").Color;
const Vector3 = @import("primitives/vector3.zig").Vector3;

const raytracer = @import("raytracer.zig");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var objects = ArrayList(Object).init(allocator);
    defer objects.deinit();

    try objects.append(Object.initSphere(.{
        .position = Vector3{.x = 0, .y = 0, .z = -5},
        .color = Color{.r = 120, .g = 120, .b = 120},
        .radius = 2,
    }));
    try objects.append(Object.initSphere(.{
        .position = Vector3{.x = -0.5, .y = 2, .z = -5},
        .color = Color{.r = 50, .g = 255, .b = 50},
        .radius = 1
    }));
    try objects.append(Object.initSphere(.{
        .position = Vector3{.x = 5, .y = 1, .z = -10},
        .color = Color{.r = 255, .g = 255, .b = 255},
        .radius = 2
    }));
    try objects.append(Object.initSphere(.{
        .position = Vector3{.x = 0, .y = -6001, .z = -10},
        .color = Color{.r = 255, .g = 50, .b = 50},
        .radius = 6000
    }));

    var lamps = ArrayList(Lamp).init(allocator);
    defer lamps.deinit();

    try lamps.append(Lamp{
        .position = Vector3{.x = 5, .y = 5, .z = 1},
        .intensity = 0.35,
    });
    try lamps.append(Lamp{
        .position = Vector3{.x = -5, .y = 5, .z = 1},
        .intensity = 0.5,
    });

    const width = 1920;
    const height = 1080;

    const camera = Camera.init(.{}, .{.z = 1}, width/height);
    const scene = Scene{
        .camera = camera,
        .objects = objects,
        .lamps = lamps,
    };
    
    const buffer = raytracer.render(scene, width, height);

    var image = try zigimg.Image.create(allocator, width, height, zigimg.PixelFormat.rgba32);
    defer image.deinit();

    for(0..(width*height)) |i|
    {
        image.pixels.rgba32[i] = .{.r = buffer[i].r, .g = buffer[i].g, .b = buffer[i].b, .a = 255};
    }

    try image.writeToFilePath("image.png", .{.png = .{}});
}
