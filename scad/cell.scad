width = 50;
height = width / 3;
wall_thickness = 2;
screw_radius = 2;

module box() {
	difference() {
		cylinder(r=width, h=height, $fn=6, center=true);
		translate([0, 0, wall_thickness])
			cylinder(r=width - wall_thickness, h=height, $fn=6, center=true);
	}
	
	translate([0, 0, height / 4])
		difference() {
			cylinder(r=width, h=wall_thickness, $fn=6, center=true);
			cylinder(r=width - (2 * wall_thickness), h=wall_thickness, $fn=6, center=true);
		}
}

module holes(shift=0) {
	for (i=[0:5]) {
		rotate([90, 0, 360 / 6 * i])
			translate([shift, 0, 0])
				cylinder(r=screw_radius, h=width, $fn=50);

		rotate([90, 0, 360 / 6 * i])
			translate([-screw_radius + shift, 0, 0])
				cube([screw_radius * 2, height, width]);
	}
}

module notch() {	
	difference() {
		union() {
			cube([5, wall_thickness, height / 2]);
			translate([0, -wall_thickness, 0])
				cube([5, wall_thickness, height / 4]);
		}
		rotate([45, 0, 0])
			translate([0, -2.5, -1.5])
				cube([5, wall_thickness * 2, height / 3]);
	}
}

module lid() {
	cylinder(r=width, h=wall_thickness, $fn=6, center=true);
	// Hooks
	for (i=[0:5]) {
		rotate([0, 0, 360 / 6 * (i + 0.5)])
			translate([width - 5 - (wall_thickness * 2), -(width / 4), -(height / 2)])
				rotate([0, 0, 90])
					notch();
					
	}
}

difference() {
//	box();
//	holes();
//	holes(width / 4);
}

translate([0, 0, 50])
	lid();