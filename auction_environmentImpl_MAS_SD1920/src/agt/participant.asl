/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!focus(A) // goal sent by the auctioneer
   <- lookupArtifact(A,ToolId);
      focus(ToolId).

+task(D)[artifact_id(AId)] : running("yes")[artifact_id(AId)]
   <- bid(math.random * 100 + 10)[artifact_id(AId)].

+winner(W) : .my_name(W) <- .print("I Won!").

/*
+task(D) : running("yes") <- bid(math.random * 100 + 10).

+winner(W) : .my_name(W) <- .print("I Won!").*/

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
