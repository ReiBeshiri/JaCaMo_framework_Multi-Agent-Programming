/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start(Id,P)
   <- makeArtifact(Id, "auction_environmentImpl_MAS_SD1920.AuctionArtifact", [], ArtId);
      .print("Auction artifact created for ",P);
      Id::focus(ArtId);  // place observable properties of this auction in a particular name space
      Id::start(P);
      .broadcast(achieve,focus(Id));  // ask all others to focus on this new artifact
      .at("now + 5 seconds", {+!decide(Id)}).

+!decide(Id)
   <- Id::stop.

+NS::winner(W) : W \== no_winner
   <- ?NS::task(S);
      ?NS::best_bid(V);
      .print("Winner v2 for ", S, " is ",W," with ", V).

/*Failure handlers */
//failure handler, in this case the auctioneer has an error starting the environment, so it retry the execution
-!start(Id,P)
	<- .print("error in starting the environment... retrying");
	   !start(Id,P).

//failure handler, in this case the event "decide" is not caught correctly, so it will generate the same event
-!decide(Id)
	<- .print("error: creating the decide event");
		!decide(Id).

/*
+!start
   <- start("lot(item5,item6, electronic good)"); //lot(item5,item6, electronic good)
      .at("now + 10 seconds", {+!decide}).

+!decide <- stop.

+winner(W) : W \== no_winner
   <- ?task(S);
      ?best_bid(V);
      .print("Winner for ", S, " is ",W," with ", V).*/

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
