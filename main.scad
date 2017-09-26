$fn = 100; // see https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Other_Language_Features#.24fa.2C_.24fs_and_.24fn

WALL_ATT_THICK = 3;
WALL_ATT_ROUND = 1;
SCREW_DIAM = 3.5;
CUTOFF_MARGIN = 1;

module roundedCube(x, y, z, r = 0) {
    translate([ r, r, r ]) {
        minkowski() {
            cube([ x - r * 2, y - r * 2, z - r * 2 ]);
            sphere(r);
        }
    }
}

module distributedHoles(
    x,
    y = 0,
    count = 2,
    d = 1,
    padding = 0,
    holeHeight = 100
) {
    z = holeHeight / -2;
    if (count == 1) {
        translate([ x / 2, y / 2, z ]) cylinder(holeHeight, r = d / 2);
    } else {
        for (i = [ 0 : count - 1 ]) {
            availableWidth = x - padding * 2 - d;
            x = d / 2 + padding + availableWidth / (count - 1) * i;
            y = y / 2;
            translate([ x, y, z ]) cylinder(holeHeight, r = d / 2);
        }
    }
}

module wallAttachment(
    width,
    height,
    thickness = WALL_ATT_THICK,
    rounding = WALL_ATT_ROUND,
    holeDiam = SCREW_DIAM
) {
    difference() {
        translate([ 0, 0, -thickness ]) roundedCube(width, height, thickness * 2, rounding);
        translate([ 0, 0, -thickness ]) cube([ width, height, thickness ]);
        distributedHoles(width, height, count = 2, d = holeDiam, padding = 5);
    }
}

module hook(
    primaryLength,
    distanceFromWall,
    secondaryLength,
    width = 10,
    rounding = WALL_ATT_ROUND,
    thickness = WALL_ATT_THICK
) {
    // Primary:
    translate([ 0, -primaryLength - thickness, 0 ])
    roundedCube(width, primaryLength + thickness, thickness, rounding);
    // Extrusion:
    translate([ 0, -primaryLength, 0 ])
    rotate([ 90, 0, 0 ])
    roundedCube(width, distanceFromWall, thickness, rounding);
    // Secondary:
    translate([ 0, -primaryLength - thickness, 0 ])
    translate([ 0, 0, distanceFromWall - thickness ])
    roundedCube(width, secondaryLength + thickness, thickness, rounding);
}

module bentCube(
    x,
    y1,
    r,
    deg,
    y2,
    z
) {
    color("red")
    cube([ x, y1, z ]);

    translate([ 0, y1, r ])
    rotate([ -90, 0, 0 ])
    rotate([ 0, 90, 0 ])
    {
        color("green")
        difference() {
            pieSlice(x, r, deg);
            translate([ 0, 0, -CUTOFF_MARGIN ])
            cylinder(x + CUTOFF_MARGIN * 2, r = r - z);
        }

        color("blue")
        rotate([ 0, 0, deg ])
        translate([ -y2, r - z, 0 ])
        cube([ y2, z, x ]);
    }
}

bentCube(x = 23, y1 = 13, r = 25, deg = 75, y2 = 16, z = 10);
