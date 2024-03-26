# Load the trajectory
mol addfile "traj_protein+2BGL.pdb" type pdb waitfor all

set num_frame [molinfo top get numframes]

# Procedure to calculate the distance between two points (in this case, centers of mass)
proc distance {c1 c2} {
   set x_diff [expr {[lindex $c2 0] - [lindex $c1 0]}]
   set y_diff [expr {[lindex $c2 1] - [lindex $c1 1]}]
   set z_diff [expr {[lindex $c2 2] - [lindex $c1 2]}]

   set distance [expr {sqrt($x_diff**2 + $y_diff**2 + $z_diff**2)}]
   return $distance
}

# Procedure to calculate S (score)
proc score {d1 d2 d3} {
   set score [expr {1000/($d1+$d2+$d3)}]
   return $score
}

set out_file [open "scores.csv" w]

for {set frame 0} {$frame < $num_frame} {incr frame} {

  animate goto $frame

  # Canculation of d1 and d2 (distances BGL1:C7-BGL2:C11 and BGL1:C11-BGL2:C7)
  set bgl1_C7 [atomselect top "resname BGL and resid 1 and name C7"] 
  set bgl1_C11 [atomselect top "resname BGL and resid 1 and name C11"]

  set bgl2_C7 [atomselect top "resname BGL and resid 2 and name C7"] 
  set bgl2_C11 [atomselect top "resname BGL and resid 2 and name C11"]

  set bgl1_C7  [lsort -unique [$bgl1_C7 get index]]
  set bgl1_C11 [lsort -unique [$bgl1_C11 get index]]

  set bgl2_C7 [lsort -unique [$bgl2_C7 get index]]
  set bgl2_C11 [lsort -unique  [$bgl2_C11 get index]]
  
  set d1 [measure bond "$bgl1_C7 $bgl2_C11"]
  set d2 [measure bond "$bgl1_C11 $bgl2_C7"]

  # Calculation of d3 (distance between centers of mass)
  set sel1 [atomselect top "resname BGL"]
  set sel2 [atomselect top "protein and resid 166 377"] 

  set c1 [measure center $sel1 weight [$sel1 get mass]]
  set c2 [measure center $sel2 weight [$sel2 get mass]]
 
  set d3 [distance $c1 $c2]
  
  set S [score $d1 $d2 $d3]
  puts $S
 
  # Frame, distances (d1, d2 and d3) and score: 
  puts $out_file "$frame,$d1,$d2,$d3,$S"

}

close $out_file

# Clear memory
mol delete 0

exit

