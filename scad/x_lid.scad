width = 50;
height = 40;
wall_thickness = 2;
face_thickness = 1;
screw_radius = 2;
notch_height = 10;

module notch() {	
	difference() {
		union() {
			cube([5, wall_thickness, notch_height]);
			translate([0, -wall_thickness, 0])
				cube([5, wall_thickness, notch_height / 2]);
		}
		rotate([45, 0, 0])
			translate([0, -2.5, -1.5])
				cube([5, wall_thickness * 2, 7]);
	}
}

module lid() {
	intersection() {
		cylinder(r=width, h=face_thickness, $fn=6, center=true);
		for (i=[0:1]) {
			rotate([0, 0, 360 / 6 * (i + 0) + 30])
				cube([15, width * 2, wall_thickness], center=true);	
		}
	}
	// Hooks
	for (i=[0:5]) {
		if ((i != 1) && (i != 4)) {
			rotate([0, 0, 360 / 6 * (i + 0)])
				translate([width - (wall_thickness * 2) + 0.7, -2.5, -notch_height])
					rotate([0, 0, 90])
						notch();
		}
	}
}


translate([0, 0, 50])
	lid();
