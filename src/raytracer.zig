const std = @import("std");

const ArrayList = std.ArrayList;
const Camera = @import("camera.zig").Camera;
const Color = @import("primitives/color.zig").Color;
const Object = @import("objects/object.zig").Object;
const Ray = @import("primitives/ray.zig").Ray;
const Vector3 = @import("primitives/vector3.zig").Vector3;
const Intersection = @import("primitives/intersection.zig").Intersection;
const Scene = @import("scene.zig").Scene;

pub fn render(scene: Scene, comptime width: comptime_int, comptime height: comptime_int) [width*height]Color
{
    var buffer: [width*height]Color = undefined;

    for(0..height) |y|
    {
        for(0..width) |x| 
        {
            const ray = scene.camera.getRay(intToFloat(x) / intToFloat(width), intToFloat(y) / intToFloat(height));
            
            const nearIntersection = getNearObject(scene, ray);

            if(nearIntersection.success)
            {
                const baseColor = nearIntersection.object.getColor();
                var illumination: f64 = 0.0;

                for(scene.lamps.items) |lamp|
                {
                    const lampDirection = lamp.position.substract(nearIntersection.intersection).normalized();
                    const shadowRay = Ray{
                        .origin = nearIntersection.intersection,
                        .direction = lampDirection
                    };

                    const shadowIntersection = getNearObject(scene, shadowRay);

                    if(shadowIntersection.success) continue;

                    illumination += lamp.intensity * shadowRay.direction.dot(nearIntersection.normal);
                }
                
                buffer[y*width+x] = baseColor.multiply(illumination);
            }
            else 
            {
                buffer[y*width+x] = Color{
                    .r = 50, 
                    .g = 50, 
                    .b = 255,
                };
            }
        }
    }

    return buffer;
}

fn getNearObject(scene: Scene, ray: Ray) Intersection
{
    var nearIntersection: Intersection = .{.object = undefined};

    for(scene.objects.items) |object|
    {
        const intersection = object.intersection(ray, 0.001);
        if(!intersection.success) continue;

        if(intersection.t < nearIntersection.t)
        {
            nearIntersection = intersection;
        }
    }

    return nearIntersection;
}

fn intToFloat(value: usize) f64
{
    return @as(f64, @floatFromInt(value));
}
