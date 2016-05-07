//constants
eps = 0.5;

// measurements
abstand_abzugskoerper = 17.5 +1.7 - 1.5;
zylinder_durchmesser = 50-eps;// größer als lochplatine, damit Stütze da ist
zylinder_hoehe = 47.9;

module bodenplatte (laenge =75, hoehe=3+eps) {
    difference (){
        color ("blue") cube ([laenge,laenge,hoehe], center = true);
#       translate ([75/2-10,75/2-10, -5]) M3Schraube();
#       translate ([75/2-10,-(75/2-10), -5]) M3Schraube();
#       translate ([-(75/2-10),(75/2-10), -5]) M3Schraube();
#       translate ([-(75/2-10),-(75/2-10), -5]) M3Schraube();        
    }
}
module zylinder_oben (durchmesser = zylinder_durchmesser , hoehe = abstand_abzugskoerper + 10) {
    cylinder (d=durchmesser, h= hoehe-eps);
}


module halterung(){
    difference (){
        union () {
            translate ([0,0, zylinder_hoehe - abstand_abzugskoerper - 10]) zylinder_oben();
            cylinder (d=zylinder_durchmesser-20, h=zylinder_hoehe-eps);
            translate ([0,0, zylinder_hoehe - abstand_abzugskoerper - 15]) cylinder (d1=zylinder_durchmesser-20, d2=zylinder_durchmesser, h=5);            
        }
#       translate ([-30,-49.5/2,zylinder_hoehe-+(abstand_abzugskoerper+1.7)]) abzugskoerper();
#       translate ([15,15, zylinder_hoehe - abstand_abzugskoerper - 15+2]) M3Schraube();
#       translate ([15,-15, zylinder_hoehe - abstand_abzugskoerper - 15+2]) M3Schraube();
#       translate ([-15,15, zylinder_hoehe - abstand_abzugskoerper - 15+2]) M3Schraube();
#       translate ([-15,-15, zylinder_hoehe - abstand_abzugskoerper - 15+2]) M3Schraube();
    }
}
//bodies for substraction
module abzugskoerper () {
    color ("red") union(){
        translate ([0,0,abstand_abzugskoerper]) RFIDreader ();
        translate ([50/2-35/2,49.5/2-26/2,5]) esp201();
        linear_extrude(height = abstand_abzugskoerper+eps) projection () Lochplatine ();    
    }
}
module M3Schraube (laenge= 18, durchmesser = 3+eps, kopfTiefe= 2, kopfDurchmesser= 5.5){
    translate ([0,0,kopfTiefe-eps]) color ("grey") cylinder (h= laenge+eps, d= durchmesser, $fn=20);
    color ("grey") cylinder (h =kopfTiefe, d=kopfDurchmesser, $fn=20);
}
module RFIDreader (laenge= 60-5, breite= 49.5, tiefe=1.5){ // -5 weil Auflagefläche auf dem Aufsatz
    color ("green") cube ([laenge, breite, tiefe]);
}

module Lochplatine (laenge= 50, breite= 49.5, tiefe=1.7){ // sollte länger als der ESP sein, damit die schrauben noch reinkönnen
    color ("orange") cube ([laenge, breite, tiefe]);
}

module esp201 (laenge= 35, breite= 26, tiefe=4) { 
    color ("white") cube ([laenge,breite, tiefe]);
}
    


halterung();
translate ([0,0,-1.5]) bodenplatte ();
