$fn=256;
height=150;
tolerance=.75;
size=70;
roundness=20;
twist=-360;
chamfer_thickness=.5;
chamfer_width=.5;
sides=2;
base_thickness=3;
base_width=2;
base_slope=base_width/base_thickness;

module base() {
    hull() {
        for (i=[1:sides])
        rotate(360/sides*i)translate([size/2-roundness,0,0])circle(roundness);
        }
}

module handle() {
    translate([0,0,-base_thickness])
    linear_extrude(base_thickness/2,scale=(size+base_slope*base_thickness)/size)base();
    scale([1,1,-1])
    linear_extrude(base_thickness/2,scale=(size+base_slope*base_thickness)/size)base();

}
module chamfer() {
translate([0,0,height-chamfer_thickness])
linear_extrude(chamfer_thickness,scale=(size-chamfer_width)/size)
base();
}

module inside() {
    union() {
        handle();
            linear_extrude(height-chamfer_thickness,slices=$fn,twist=twist)base();
            chamfer();
    }
}
module outside() {
linear_extrude(height,slices=$fn,twist=twist)offset(tolerance)base();
}
PART=undef;
if (PART=="inside") {
inside();
}
if (PART=="outside") {
outside();
}
