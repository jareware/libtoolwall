include <../config.scad>;

use <../primitives/distributeChildren.scad>;
use <../utilities/screwHole.scad>;

// Example:
basket(
  30,
  20,
  5,
  10
);

module basket(
  width,
  height,
  depth,
  coverHeight
) {

  outerWidth = width + WALL_THICKNESS * 2;
  outerHeight = height + WALL_THICKNESS * 1;
  outerDepth = depth + WALL_ATTACHMENT_THICKNESS + WALL_THICKNESS;

  difference() {
    translate([ 0, 0, 0 ]) {
      // Wall attachment:
      cube([ outerWidth, outerHeight, WALL_ATTACHMENT_THICKNESS ]);

      // Walls:
      cube([ outerWidth, WALL_THICKNESS, outerDepth ]);
      cube([ WALL_THICKNESS, coverHeight, outerDepth ]);
      translate([ outerWidth - WALL_THICKNESS, 0, 0 ])
      cube([ WALL_THICKNESS, coverHeight, outerDepth ]);

      // Cover:
      translate([ 0, 0, outerDepth - WALL_THICKNESS ])
      cube([ outerWidth, coverHeight, WALL_THICKNESS ]);
    }

    translate([ outerWidth / 2, outerHeight / 2, 0 ])
    screwHole();
  }

  // // Test object:
  // color("red")
  // translate([ WALL_THICKNESS, WALL_THICKNESS, WALL_ATTACHMENT_THICKNESS ])
  // cube([ width, height, depth ]);

}
