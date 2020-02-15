/* Initial beliefs and rules */

/* Initial goals */
!start. // initial goal

/* Plans */
/* Send a broadcast msg to all agents to tell the auction is open*/
+!start <- .broadcast(tell, auction(service, lot(item5,item6,"electronic good"))).

/* receives bids and checks for new winner*/
+bid(Service, _)
	:  .findall(b(V,A),bid(Service,V)[source(A)],L) &
       .length(L,4) //check if there are actually 4 participants
    <- .max(L,b(V,W)); //get the max from L and put the result on b(V,W)
       .print("Winner for ", Service, " is ",W," with ", V);
       .broadcast(tell, winner(Service,W)).


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }