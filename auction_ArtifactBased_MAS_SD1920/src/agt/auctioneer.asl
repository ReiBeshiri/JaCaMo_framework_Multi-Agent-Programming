// Agent sample_agent in project auction_ArtifactBased_MAS_SD1920

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!start(Idsublist, Idscoreboard, Idauction,P)
	<- makeArtifact(Idscoreboard, "auction_ArtifactBased_MAS_SD1920.ScoreBoardArtifact", [], ArtIdscoreboard);
	   makeArtifact(Idsublist, "auction_ArtifactBased_MAS_SD1920.SubscriptionArtifact", [], ArtIdsublist);
	   .print("Auction artifact created for scoreboard and sublist, for",P);
       Idsublist::focus(ArtIdsublist);  // place observable properties of this auction in a particular name space
       Idsublist::start(P);
       .broadcast(achieve,startsub(Idsublist));  // ask all others to focus on this new artifact (to sub the auction)
       .print("Waiting 10 second for participant to sub...")
       .at("now + 10 seconds", {+!endsub(Idsublist, Idscoreboard, Idauction,P)}).
       
+!endsub(Idsublist, Idscoreboard, Idauction,P) <- Idsublist::stop; !startauction(Idsublist, Idscoreboard, Idauction, P).

+!startauction(Idsublist, Idscoreboard, Idauction, P) 
	<- makeArtifact(Idauction, "auction_ArtifactBased_MAS_SD1920.AuctionRoomArtifact", [], ArtIdauction);
       .print("Auction room artifact created for ",P);
       Idauction::focus(ArtIdauction);  // place observable properties of this auction in a particular name space
       Idauction::start(P);
       .broadcast(achieve,startbid(Idauction));  // ask all others to focus on this new artifact (to enter auction room)
       .print("10 seconds until the end of the auction")
       .at("now + 10 seconds", {+!endauction(Idsublist, Idscoreboard, Idauction,P)});.
       
+!endauction(Idsublist, Idscoreboard, Idauction,P)  
	<- .print("Auction finisched");
	   Idauction::stop;.
      
+NS::winner(W) : W \== no_winner
   <- ?NS::task(S);
      ?NS::best_bid(V);
      .print("Winner for ", S, " is ",W," with ", V).      

-!start : true <- .print("error start auctioneer").
-!endsub : true <- .print("error endsub auctioneer").
-!startauction : true <- .print("error startauction auctioneer").
-!endauction : true <- .print("error endauction auctioneer").


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
