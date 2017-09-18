$fn = 100; // see https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Other_Language_Features#.24fa.2C_.24fs_and_.24fn

WALL_ATT_THICK = 3;
WALL_ATT_ROUND = 1;
SCREW_DIAM = 3.5;

wallAttachment(30, 10, 3, 1);

module roundedCube(x, y, z, r) {
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
    padding = 1,
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
    thickness = 3,
    rounding = 1,
    holeDiam = 3.5
) {
    difference() {
        translate([ 0, 0, -thickness ]) roundedCube(width, height, thickness * 2, rounding);
        translate([ 0, 0, -thickness ]) cube([ width, height, thickness ]);
        distributedHoles(width, height, count = 2, d = holeDiam, padding = 2);
    }
}
