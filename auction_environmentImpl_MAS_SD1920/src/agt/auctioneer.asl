/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start
   <- start("lot(item5,item6, electronic good)"); //lot(item5,item6, electronic good)
      .at("now + 10 seconds", {+!decide}).

+!decide <- stop.

+winner(W) : W \== no_winner
   <- ?task(S);
      ?best_bid(V);
      .print("Winner for ", S, " is ",W," with ", V).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
