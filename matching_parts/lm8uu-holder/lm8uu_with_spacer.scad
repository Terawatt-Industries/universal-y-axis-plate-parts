use <lm8uu-holder-slim_v1-1.scad>

lm8uu_with_spacer(25);

module mount_plate()
{
	difference()
	{ 
		hull() {
			cube([36,24,25], center=true);
			cube([50,10,25], center=true);
		}
		for(i=[-1,1]) {
			translate([i * (15.625), 0, -12.51])
				cylinder(r=1.75, h=25.02, $fn=20);
			// nut trap
			translate([i * (15.625), 0, 8.75])
				rotate([0, 0, 90])
					cylinder(r=4, h=20, $fn=6);
		}
	}
}

module lm8uu_with_spacer(spacer_height) {
  translate([0, 0, spacer_height]) lm8uu_holder(0);		// WITH mountplate
  translate([0, 0, 12.5]) cube([22, 24, 25], center=true);
  translate([0, 0, 12.5]) mount_plate();
}
