+!bid[scheme(Sch)]
   <- ?goalArgument(Sch,auction,"Id",Id); 		  // retrieve auction id and focus on the artifact
      lookupArtifact(Id,AId);
      focus(AId);
      if (math.random  < 0.9) {		              // bid in 90% of the cases
         .wait(500);     					      // to simulate some "decision" reasoning
         bid(math.random * 100 + 10)[artifact_id(AId)];
      }
      !rebid(AId).

+!rebid(AId) : running("yes")[artifact_id(Artid)] & not winner(.my_name) & best_bid(W)
	<- if (math.random  < 0.9) {		              // bid in 90% of the cases
         .wait(500);     					          // to simulate some "decision" reasoning
         bid(math.random * 15 + W)[artifact_id(AId)];
      }
      !rebid(AId).

-!bid[error(ia_failed)] <- .print("I didn't bid!").
-!bid[error_msg(M)]     <- .print("Error bidding: ",M).
-!rebid(AId) : true <- true.

+winner(W) : .my_name(W) <- .print("I Won!").

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
