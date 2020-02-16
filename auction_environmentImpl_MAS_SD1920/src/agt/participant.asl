/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+task(D) : running("yes") <- bid(math.random * 100 + 10).

+winner(W) : .my_name(W) <- .print("I Won!").

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
