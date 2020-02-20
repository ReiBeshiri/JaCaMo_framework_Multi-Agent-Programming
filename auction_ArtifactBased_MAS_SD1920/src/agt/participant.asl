// Agent participant in project auction_ArtifactBased_MAS_SD1920

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!startsub(Idsublist)
	<- lookupArtifact(Idsublist, Artid);
	   Idsublist::focus(Artid);
	   Idsublist::sub.
	   
	   
+!startbid(Idauction)
	<- lookupArtifact(Idauction, Artid);
	   focus(Artid);
	   !bids(Idauction, Artid).
	
	
+!bids(Idauction, Artid): running("yes")[artifact_id(Artid)] & not winner(.my_name) & best_bid(W)
	<- .wait(500);
	   bid(W + math.random * 15)[artifact_id(AId)];
	   !bids(Idauction, Artid).


-!startsub(Idsublist) : true 
	<- .print("error during the sub in the auction list, retrying... ");
	   !startsub(Idsublist).
-!startbid(Idauction) : true 
	<- .print("error in starting the bid, retrying...");
	   !startbid(Idauction).
-!bids(Idauction, Artid) : true 
	<- stopFocus(Artid).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
