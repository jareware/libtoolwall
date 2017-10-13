include <../config.scad>;

use <../primitives/roundedCube.scad>;
use <../utilities/autoScrewHoles.scad>;

// Example:
clamp(
  width = 20,
  height = 30,
  depth = 2.75,
  bottomExtraSturdiness = 4,
  topExtraSturdiness = 2,
  extraDistanceFromWall = 3,
  cutoutPadding = 4,
  $fn = 20
);

module clamp(
  width,
  height,
  depth,
  bottomExtraSturdiness = 0,
  topExtraSturdiness = 0,
  extraDistanceFromWall = 0,
  edgePadding = 5,
  cutoutPadding = 0
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

    // When using extra extrusion, remove some unnecessary volume:
    if (extraDistanceFromWall > GLOBAL_ROUNDING) { // take GLOBAL_ROUNDING into account, because roundedCube gets weird when its dimensions are less than its rounding
      _cutoutPadding = cutoutPadding ? cutoutPadding : (width - SCREW_ACCESS_DIAMETER) / 2;
      translate([ _cutoutPadding, wallThickBot, WALL_ATTACHMENT_THICKNESS + SOLID_MERGE_MARGIN ])
      roundedCube(width - _cutoutPadding * 2, height, extraDistanceFromWall, r = GLOBAL_ROUNDING, flatTop = true, flatFront = true, flatBack = true);
    }

    // Add screw holes:
    autoScrewHoles(
      areaWidth = mountWidth,
      areaHeight = mountHeight,
      padding = edgePadding
    );

  }

}
