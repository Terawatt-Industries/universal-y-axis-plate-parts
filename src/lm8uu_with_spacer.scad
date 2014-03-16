/*
Universal Y-Axis Plate Matching Parts by Longevity Software LLC d.b.a. Terawatt Industries is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.  NOTE:  this license only applies to the matching parts repository (for the Universal Y-Axis Plate fulfilled by Terawatt Industries).  The Universal Y-Axis Plate source files are licensed separately.
*/
use <lm8uu-holder-slim_v1-1.scad>

//screw/nut dimensions (M3) - hexagon socket head cap screw ISO 4762, hexagon nut ISO 4032
screw_thread_dia_iso = 3 + 0.65;
screw_head_dia_iso = 6.35 + 0.55;
nut_wrench_size_iso = 6.35 + 0.55;
nut_height = 4.5;

// screw/nut dimensions for use (plus clearance for fitting purpose)
screw_thread_dia = screw_thread_dia_iso;
screw_head_dia = screw_head_dia_iso;
nut_wrench_size = nut_wrench_size_iso;

lm8uu_with_spacer(33);

module mount_plate(h, nutz)
{
	difference()
	{ 
		hull() {
			cube([36,24,h], center=true);
			cube([50,10,h], center=true);
		}
		for(i=[-1,1]) {
			translate([i * (15.5), 0, h / 2 - 0.1])
				cylinder(r=screw_thread_dia / 2, h=h * 2 + 0.02, center = true, $fn=20);
			if (nutz) {
				// nut trap
				translate([i * (15.5), 0, h / 2 - nut_height + 0.01])
					rotate([0, 0, 90])
						cylinder(r=nut_wrench_size / 2, h = nut_height, $fn=6);
			}
		}
	}
}

module bushing_spacer(spacer_height) {
  difference() {
    translate([0, 30.5, spacer_height / 2]) mount_plate(spacer_height, false);
	// save some material?
    translate([0, 30.5, spacer_height / 2]) cube([11, 11, spacer_height / 2], center=true);
  }
}

module wrap_lm8uu_holder(spacer_height) {
	// hack - fill in lm8uu holder mount holes then punch again
	difference() {
		union() {
			translate([0, 0, 5]) lm8uu_holder(1);		// without mountplate
			for(i=[-1,1]) {
				translate([i * (15.5), 0, 5])
				rotate([0, 0, 90])
					cylinder(r=nut_wrench_size / 2, h = 3, $fn=20);
			}
		}
		spacer_screw_holes(25);
		for(i=[-1,1]) {
			// nut trap
			translate([i * (15.5), 0, nut_height + 0.01])
			rotate([0, 0, 90])
				cylinder(r=nut_wrench_size / 2, h = nut_height, $fn=6);
		}
	}
}

module spacer_screw_holes(height) {
		for(i=[-1,1]) {
			translate([i * (15.5), 0, 5])
			cylinder(r=screw_thread_dia / 2, h = height, center = true, $fn=20);
		}
}

module lm8uu_with_spacer(spacer_height) {
	translate([0, 0, 5 / 2]) mount_plate(5, false);
	wrap_lm8uu_holder(spacer_height);
	bushing_spacer(spacer_height);
}
