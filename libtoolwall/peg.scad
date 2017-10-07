include <../config.scad>;

use <../primitives/roundedCube.scad>;
use <../utilities/screwHole.scad>;

// Example:
peg(
  length = 6,
  diameter = 4,
  padding = 5,
  endTwistDeg = 9,
  endTwistLength = 2,
  middlePaddingAdjust = -3,
  $fn = 25
);

module peg(
  length,
  diameter,
  padding,
  endTwistDeg = 0,
  endTwistLength = 0,
  middlePaddingAdjust = 0
) {

  middlePadding = padding + middlePaddingAdjust;
  biggestD = diameter > SCREW_HEAD_DIAMETER ? diameter : SCREW_HEAD_DIAMETER; // which diameter dominates
  mountWidth = padding + biggestD + padding; // left to right
  mountHeight = padding + SCREW_HEAD_DIAMETER + middlePadding + diameter + padding; // top to bottom
  pegR = diameter / 2;

  difference() {

    // Wall mount:
    roundedCube(mountWidth, mountHeight, WALL_ATTACHMENT_THICKNESS, r = GLOBAL_ROUNDING, flatBottom = true);

    // Add screw hole:
    translate([ mountWidth / 2, padding + middlePadding + SCREW_HEAD_DIAMETER / 2 + diameter, 0 ])
    screwHole();

  }

  translate([ mountWidth / 2, pegR + padding, WALL_ATTACHMENT_THICKNESS ]) {

    // Main peg extrusion:
    cylinder(r = pegR, h = length - pegR);

    // Twist at the end:
    hull() {
      translate([ 0, 0, length - pegR ])
      sphere(r = pegR);
      rotate([ -endTwistDeg, 0, 0 ])
      translate([ 0, 0, length - pegR + endTwistLength ])
      sphere(r = pegR);
    }

  }

}
