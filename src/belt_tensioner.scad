// Gregs configuration file
include <configuration.scad>

$fn = 20;

belt_width=6;
belt_thickness=1.5; 
tooth_height=1.5;
tooth_spacing=2;

belt_clamp_thickness=15.5; 
//belt_clamp_width=m3_diameter+3*belt_clamp_thickness+2;
belt_clamp_width = 12;

belt_clamp_hole_separation=18;

belt_clamp_height=m3_diameter+2*belt_clamp_thickness;
belt_clamp_length=belt_clamp_hole_separation+m3_diameter+2*belt_clamp_thickness;

belt_clamp_channel_height=belt_thickness+tooth_height+belt_clamp_thickness*1.4;
belt_clamp_clamp_height=tooth_height+belt_clamp_thickness*1.75;

for (i=[-1])
translate([0,i*(belt_clamp_width+1),0])
belt_clamp(belt_clamp_clamp_height);

belt_clamp_channel(belt_clamp_channel_height);

for (i=[1,2,3])
translate([0,i*(belt_clamp_width+1),0])
belt_clamp(5.5);

module belt_clamp_socket(bch)
{
	difference()
	{
		translate([0,0,bch/2])
		union()
		{
			cube([belt_clamp_hole_separation,belt_clamp_width,bch],center=true);
			for(i=[-1,1])
			translate([i*belt_clamp_hole_separation/2,0,0])
			cylinder(r=belt_clamp_width/2,h=bch,center=true);
		}
		belt_clamp_holes(bch + 2);
	}
}

module belt_clamp_channel(bcchh = belt_clamp_channel_height)
{
	difference()
	{
		translate([0,0,bcchh/2])
		union()
		{
			cube([belt_clamp_hole_separation,belt_clamp_width,bcchh],center=true);
			for(i=[-1,1])
			translate([i*belt_clamp_hole_separation/2,0,0])
			cylinder(r=belt_clamp_width/2,h=bcchh,center=true);
		}

		belt_clamp_holes(belt_clamp_height + 2);

		translate([-belt_width/2,-belt_clamp_width/2-1,bcchh - belt_thickness-tooth_height])
		cube([belt_width,belt_clamp_width+2,belt_thickness+tooth_height+1]);
	}
}

module belt_clamp_holes(height = belt_clamp_height)
{
	translate([0,0,belt_clamp_height/2])
	{
		for(i=[-1,1])
		translate([i*belt_clamp_hole_separation/2,0,0])
		cylinder(r=m3_diameter/2,h=height,center=true);	
	}
}

module belt_clamp(bcch = belt_clamp_clamp_height)
{
	difference()
	{
		translate([0,0,bcch/2])
		union()
		{
			cube([belt_clamp_hole_separation,belt_clamp_width,bcch],center=true);
			for(i=[-1,1])
			translate([i*belt_clamp_hole_separation/2,0,0])
			cylinder(r=belt_clamp_width/2,h=bcch,center=true);
		}
		belt_clamp_holes();
		for(i=[-1:1])
		translate([-belt_width/2,-tooth_spacing/4+i*tooth_spacing,bcch - tooth_height])
		cube([belt_width,tooth_spacing/2,tooth_height+1]);
	}
}

