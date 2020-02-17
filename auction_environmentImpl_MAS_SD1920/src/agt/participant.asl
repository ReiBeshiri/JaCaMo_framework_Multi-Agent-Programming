/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!focus(A) // goal sent by the auctioneer
   <- lookupArtifact(A,ToolId);
      focus(ToolId);.
      //!rebid(A,ToolId).


+task(D)[artifact_id(AId)] : running("yes")[artifact_id(AId)] & not winner(.my_name)
   <- bid(math.random * 100 + 10)[artifact_id(AId)];?rebid(AId).

+winner(W) : .my_name(W) <- .print("I Won!").

+?rebid(AId) : running("yes")[artifact_id(AId)] & not winner(.my_name) & best_bid(W)
	<- .wait(500);
	   rebid(W + math.random * 15)[artifact_id(AId)];
	   ?rebid(AId).

//failure handling plans, in this case it's equivalent to the end of the auction
-?rebid(AId): true <- true.

/*
+task(D) : running("yes") <- bid(math.random * 100 + 10).

+winner(W) : .my_name(W) <- .print("I Won!").
* 
* 
* //error(action_failed)
//error_msg("You can not bid, auction not available. It is not running!")
//code_src("participant.asl")
* 
* 
* //-?rebid[error(action_failed),
//    error_msg("You can not bid, auction not available. It is not running!"),
//    code_src("participant.asl")] <- .print("end").
* 
* */

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
