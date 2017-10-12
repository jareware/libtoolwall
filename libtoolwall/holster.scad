include <../config.scad>;

use <../primitives/roundedCube.scad>;
use <../utilities/autoScrewHoles.scad>;

// Example:
holster(
  width = 30,
  height = 30,
  depth = 2.5,
  $fn = 20
);

module holster(
  width,
  height,
  depth,
  windowPadding = 7.5,
  groovePadding = 2.5,
  edgePadding = 1
) {
  outerWidth = width + WALL_THICKNESS * 2;
  outerHeight = height + WALL_THICKNESS * 1;
  outerDepth = depth + WALL_ATTACHMENT_THICKNESS + WALL_THICKNESS;

  difference() {

    union() {

      // Wall mount:
      roundedCube(outerWidth, outerHeight, WALL_ATTACHMENT_THICKNESS, r = GLOBAL_ROUNDING, flatBottom = true);

      // Left side:
      translate([ 0, 0, WALL_ATTACHMENT_THICKNESS + depth ])
      roundedCube(WALL_THICKNESS + windowPadding, outerHeight, WALL_THICKNESS, r = GLOBAL_ROUNDING, flatBottom = true);
      roundedCube(WALL_THICKNESS, outerHeight, WALL_ATTACHMENT_THICKNESS + depth, r = GLOBAL_ROUNDING, flatBottom = true, flatTop = true, flatRight = true);

      // Right side:
      translate([ outerWidth - WALL_THICKNESS - windowPadding, 0, WALL_ATTACHMENT_THICKNESS + depth ])
      roundedCube(WALL_THICKNESS + windowPadding, outerHeight, WALL_THICKNESS, r = GLOBAL_ROUNDING, flatBottom = true);
      translate([ outerWidth - WALL_THICKNESS, 0, 0 ])
      roundedCube(WALL_THICKNESS, outerHeight, WALL_ATTACHMENT_THICKNESS + depth, r = GLOBAL_ROUNDING, flatBottom = true, flatTop = true, flatLeft = true);

      // Bottom side:
      roundedCube(outerWidth, WALL_THICKNESS + windowPadding, outerDepth, r = GLOBAL_ROUNDING, flatBottom = true);

    }

    // Remove space for contained object:
    translate([ WALL_THICKNESS, WALL_THICKNESS, WALL_ATTACHMENT_THICKNESS ])
    #cube([ width, height, depth ]);

    // Add screw holes:
    autoScrewHoles(
      areaWidth = width - windowPadding * 2,
      areaHeight = height - windowPadding - edgePadding,
      translateX = WALL_THICKNESS + windowPadding,
      translateY = WALL_THICKNESS + windowPadding,
      padding = 0
    );

  }

}
