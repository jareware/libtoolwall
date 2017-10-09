include <../config.scad>;

use <../primitives/roundedCube.scad>;
use <../utilities/screwHole.scad>;

// Example:
clamp(
  width = 20,
  height = 30,
  depth = 2.75,
  bottomExtraSturdiness = 4,
  topExtraSturdiness = 2,
  extraDistanceFromWall = 3,
  $fn = 20
);

module clamp(
  width,
  height,
  depth,
  bottomExtraSturdiness = 0,
  topExtraSturdiness = 0,
  extraDistanceFromWall = 0
) {
  wallThickBot = WALL_THICKNESS + bottomExtraSturdiness;
  wallThickTop = WALL_THICKNESS + topExtraSturdiness;
  mountWidth = width;
  mountHeight = wallThickBot + height;
  mountDepth = WALL_ATTACHMENT_THICKNESS + extraDistanceFromWall + depth + wallThickTop;

  difference() {

    // Main body:
    roundedCube(mountWidth, mountHeight, mountDepth, r = GLOBAL_ROUNDING, flatBottom = true);

    // Remove space for object:
    translate([ 0, wallThickBot, WALL_ATTACHMENT_THICKNESS + extraDistanceFromWall ])
    cube([ width, height, depth ]);

    // Add screw holes:
    translate([ mountWidth / 2, mountHeight - SCREW_ACCESS_DIAMETER / 2 - wallThickBot, 0 ])
    screwHole();
    translate([ mountWidth / 2, wallThickBot + SCREW_ACCESS_DIAMETER / 2, 0 ])
    screwHole();

  }

}
