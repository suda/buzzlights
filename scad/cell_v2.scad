mode = 3; // 1 = box, 2 = lid, 3 = both
width = 50;
height = 30;
wall_thickness = 1;
face_thickness = 1;
connector_width = 20;
connector_height = 5;
notch_height = 10;

module box() {
	difference() {
		minkowski() {
			cylinder(r=width - (wall_thickness * 1.5), h=height, $fn=6, center=true);
			sphere(r=wall_thickness, $fn=20);
		}
		translate([0, 0, face_thickness * wall_thickness + 3.5])
			cylinder(r=width - wall_thickness, h=height + 10, $fn=6, center=true);
		translate([0, 0, height])
			cube([width * 2, width * 2, height], center=true);
	}
}

module holes() {
	for (i=[0:5]) {
		rotate([90, 0, 360 / 6 * i])
			translate([-(connector_width / 2), (height / 2) - (connector_height / 2), 0])
				cube([connector_width, connector_height, width]);
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
	for (i=[0:2]) {
		rotate([0, 0, 360 / 6 * (i + 0)])
			cube([connector_width, width * 2 - 14, wall_thickness], center=true);	
	}
	//cylinder(r=width - wall_thickness - 2, h=face_thickness, $fn=6, center=true);
	// Hooks
	//for (i=[0:5]) {
//		rotate([0, 0, 360 / 6 * (i + 0)])
//			translate([width - (wall_thickness * 2), -2.5, -notch_height])
//				rotate([0, 0, 90])
//					notch();
//					
//	}
}

if (mode == 1 || mode == 3) {
	difference() {
		box();
		holes();
	}
}

if (mode == 2 || mode == 3) {
	translate([0, 0, 20])
		lid();
}