include <../config.scad>;

// Example:
screwHole();

module screwHole() {
  // Main:
  cylinder(SCREW_FREE_SPACE, r = SCREW_MAIN_DIAMETER / 2, $fn = SCREW_ARC_FN);
  // Head embed:
  translate([ 0, 0, WALL_ATTACHMENT_THICKNESS - SCREW_HEAD_EMBED ])
  cylinder(SCREW_FREE_SPACE, r = SCREW_HEAD_DIAMETER / 2, $fn = SCREW_ARC_FN);
}
