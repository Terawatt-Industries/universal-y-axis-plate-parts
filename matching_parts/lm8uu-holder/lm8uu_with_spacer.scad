use <lm8uu-holder-slim_v1-1.scad>

//screw/nut dimensions (M3) - hexagon socket head cap screw ISO 4762, hexagon nut ISO 4032
screw_thread_dia_iso = 3;
screw_head_dia_iso = 5.5;
nut_wrench_size_iso = 5.5;
nut_height = 3.0;

// screw/nut dimensions for use (plus clearance for fitting purpose)
clearance_dia = 0.5;
screw_thread_dia = screw_thread_dia_iso + clearance_dia;
screw_head_dia = screw_head_dia_iso + clearance_dia;
nut_wrench_size = nut_wrench_size_iso + clearance_dia;

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
			translate([i * (15.5), 0, -12.501])
				cylinder(r=screw_thread_dia / 2, h=25.02, $fn=20);
			// nut trap
			translate([i * (15.5), 0, 12.5 - nut_height + 0.01])
				rotate([0, 0, 90])
					cylinder(r=nut_wrench_size / 2, h = nut_height, $fn=6);
		}
	}
}

module lm8uu_with_spacer(spacer_height) {
  translate([0, 0, spacer_height]) lm8uu_holder(0);		// WITH mountplate
  translate([0, 0, spacer_height / 2]) cube([22, 24, spacer_height], center=true);
  translate([0, 0, spacer_height / 2]) mount_plate();
}
