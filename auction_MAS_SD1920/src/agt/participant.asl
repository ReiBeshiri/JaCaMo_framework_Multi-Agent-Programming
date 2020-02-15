/* Initial beliefs and rules */

/* Initial goals */

/* Plans */
/* The participants send to the auctioneer their bids*/
+auction(service, D)[source(A)] <- .send(A,tell,bid(D, math.random * 100 + 10)).
/*
 * each time the participant gets an event corresponding to the creation of an auction belief for a service,
 * it sends back a bid with a price. Service, after +auction(, is not a variable is a constant,
 * so this agent will only respond to auctions for services. Variable D is bound to the description of the
 * service and variable A is bound to the source of the auctioneer.
 * The message has the format bib( <service description>, <price>)
 */


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
