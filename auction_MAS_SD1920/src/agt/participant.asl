/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

/* The participants send to the auctioneer their bids*/
+auction(service, D)[source(A)] <- .broadcast(tell, bid(D, math.random * 100 + 10)).

/*
 * each time the participant gets an event corresponding to the creation of an auction belief for a service,
 * it sends back a bid with a price. Service, after +auction(, is not a variable is a constant,
 * so this agent will only respond to auctions for services. Variable D is bound to the description of the
 * service and variable A is bound to the source of the auctioneer.
 * The message has the format bib( <service description>, <price>)
 */

/* If an agent made a subsequent bid required, this will be 10% higher than the max current bid */
+bid(S,_) : not .desire( bid(S) ) <- !bid(S).
+!bid(S)
   <- .wait(1000);
      .findall(V,bid(S,V),L);
      .max(L,MV);
      .broadcast(tell,bid(S, MV*1.1));
      .print("Bid ",MV*1.1, " for ",S).


//include
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
