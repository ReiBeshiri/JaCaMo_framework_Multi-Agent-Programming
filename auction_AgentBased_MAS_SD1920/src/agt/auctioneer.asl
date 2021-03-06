/* Initial beliefs and rules */

/* Initial goals */
!start. // initial goal

/* Plans */
/* Send a broadcast msg to all agents to tell the auction is open*/
/* Start two auction at the same time, and executed concurrently. Participants can produce bids concurrently */
+!start 
		: true 
		<- .broadcast(tell, auction(service, lot(item5,item6, "electronic good")));
		   .broadcast(tell, auction(service, lot(item7,item8, "hardware components")));
		   .at("now + 7 seconds", {+!decide(lot(item5,item6, "electronic good"))});
	       .at("now + 7 seconds", {+!decide(lot(item7,item8, "hardware components"))}).

/* receives bids and checks for new winner*/
+!decide(Service)
	:  .findall(b(V,A),bid(Service,V)[source(A)],L)
    <- .max(L,b(V,W)); //get the max from L and put the result on b(V,W)
       .print("Winner for ", Service, " is ",W," with ", V, ". Partecipants=",L);
       .broadcast(tell, winner(Service,W));
       .broadcast(untell, auction(service, Service))
       .broadcast(achieve, endbid(ends)).
       //.kill_all_agents
       //.suspend

/*Failure handlers */
//failure in start intentions, when the auctioneer is trying to broadcast the start message
-!start
	<- .print("error starting the auction, retrying...");
	   !start.
	
//failure when decide event is caught, regenerating the event
-!decide(Service)
	<- .print("error: creating the decide event");
		!decide(Service).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }