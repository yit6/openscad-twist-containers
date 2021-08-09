$fn=256;
height=100;
tolerance=.75;
size=70;
roundness=25;
twist=90;
chamfer_thickness=.5;
chamfer_slope=1.5;
sides=5;
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
module chamfer_cutter() {
translate([0,0,height])
rotate([180,0,0])
difference() {
translate([0,0,-1])linear_extrude(height)square(size*1.5,center=true);
rotate([0,0,twist])
linear_extrude(slices=$fn,height,twist=twist,scale=(size-chamfer_thickness+1/chamfer_slope*height)/(size-chamfer_thickness))
offset(-chamfer_thickness)base();
}
}
module inside() {
    union() {
        handle();
        difference() {
            linear_extrude(height,slices=$fn,twist=twist)base();
            chamfer_cutter();
        }
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
