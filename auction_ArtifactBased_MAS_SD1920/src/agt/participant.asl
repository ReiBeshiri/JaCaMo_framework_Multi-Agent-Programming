// Agent participant in project auction_ArtifactBased_MAS_SD1920

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!startsub(Idsublist)
	<- lookupArtifact(Idsublist, Artid);
	   Idsublist::focus(Artid);
	   Idsublist::sub.
	   
	   
+!startbid(Idauction)
	<- lookupArtifact(Idsublist, Artid);
	   Idauction::focus(Artid);
	   !bid(Idsublist, Artid).
	
	
+!bid(Idsublist, Artid): running("yes")[artifact_id(Artid)] & not winner(.my_name) & best_bid(W)
	<- .wait(500);
	   bid(W + math.random * 15)[artifact_id(AId)];
	   !bid(Idsublist, Artid).


-!startsub(Idsublist) : true <- .print("error start sub part").
-!subtoauction(Idsublist, Artid) : true <- .print("error subtoauction part").
-!startbid(Idauction) : true <- .print("error startbid part").
-!bid(Idsublist, Artid) : true <- .print("error bid part").

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
