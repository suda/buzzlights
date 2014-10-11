mode = 1; // 1 = box, 2 = lid, 3 = both
width = 50;
height = 40;
wall_thickness = 2;
face_thickness = 1;
screw_radius = 2;
notch_height = 10;

module box() {
	difference() {
		cylinder(r=width, h=height, $fn=6, center=true);
		translate([0, 0, face_thickness])
			cylinder(r=width - wall_thickness, h=height, $fn=6, center=true);
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
	cylinder(r=width, h=face_thickness, $fn=6, center=true);
	// Hooks
	for (i=[0:5]) {
		rotate([0, 0, 360 / 6 * (i + 0)])
			translate([width - (wall_thickness * 2), -2.5, -notch_height])
				rotate([0, 0, 90])
					notch();
					
	}
}

if (mode == 1 || mode == 3) {
	difference() {
		box();
		holes();
	}
}

if (mode == 2 || mode == 3) {
	translate([0, 0, 50])
		lid();
}