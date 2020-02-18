// CArtAgO artifact code for project auction_environmentImpl_MAS_SD1920

package auction_environmentImpl_MAS_SD1920;

import jason.asSyntax.Atom;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import cartago.*;

public class AuctionArtifact extends Artifact {

    String currentWinner = "no_winner";
    String errorMsg = "no_errors";
    /*
     * Double -> value of the bid.
     * String  -> description of the bid.
     * */
    HashMap<Double, String> auctionInfo = new HashMap<Double, String>();
    
    public void init()  {
        // observable properties
        defineObsProperty("running",     "no");
        defineObsProperty("best_bid",    Double.MIN_VALUE);
        defineObsProperty("winner",      new Atom(currentWinner)); //Atom -- the most simple literal, is composed by only a functor (no term, no annots)
        auctionInfo.put(0.0, "iniziated auction for " + getId().toString());
    }

    @OPERATION public void start(String task)  {
        if (getObsProperty("running").stringValue().equals("yes")) {
            failed("The protocol is already running and so you cannot start it!");
        	errorMsg = "already_running";
        }

        defineObsProperty("task", task);
        getObsProperty("running").updateValue("yes");
    }

    @OPERATION public void stop()  {
        if (! getObsProperty("running").stringValue().equals("yes")) {
            failed("The protocol is not running, you cannot stop it!");
        	errorMsg = "already_stopped";
        }

        getObsProperty("running").updateValue("no");
        getObsProperty("winner").updateValue(new Atom(currentWinner));
        //lambda not allowed with this java version
        //auctionInfo.forEach((k,v) -> System.out.println("key: "+k+" value:"+v));
        List<Double> sortedKeys=new ArrayList<Double>(auctionInfo.keySet());
        Collections.sort(sortedKeys);
    	for(int i = 0; i<sortedKeys.size(); i++) {
    		System.out.println(sortedKeys.get(i) + " " + auctionInfo.get(sortedKeys.get(i)).toString());
    	}
    }

    @OPERATION public void bid(double bidValue) {
        if (getObsProperty("running").stringValue().equals("no")) {
            failed("You can not bid, auction not available. It is not running!");
        	errorMsg = "bid_intention";
        }

        ObsProperty opCurrentValue  = getObsProperty("best_bid");
        if (bidValue > opCurrentValue.doubleValue()) {  // the bid is better than the previous
            opCurrentValue.updateValue(bidValue);
            currentWinner = getCurrentOpAgentId().getAgentName(); // the name of the agent doing this operation
        }
        System.out.println("Received bid "+bidValue+" from "+getCurrentOpAgentId().getAgentName()+" for "+getObsProperty("task").stringValue());
        auctionInfo.put(bidValue, "bid from "+getCurrentOpAgentId().getAgentName() + " for " + getId().toString());
    }
    
    @OPERATION public void rebid(double bidValue) {
    	if (getObsProperty("running").stringValue().equals("no")) {
            failed("You can not bid, auction not available. It is not running!");
    		errorMsg = "bid_intention";
    	}

        ObsProperty opCurrentValue  = getObsProperty("best_bid");
        if (bidValue > opCurrentValue.doubleValue() && currentWinner != getCurrentOpAgentId().getAgentName()) {  // the bid is better than the previous
            opCurrentValue.updateValue(bidValue);
            currentWinner = getCurrentOpAgentId().getAgentName(); // the name of the agent doing this operation            
        }
        System.out.println("Received rebid "+bidValue+" from "+getCurrentOpAgentId().getAgentName()+" for "+getObsProperty("task").stringValue());
        auctionInfo.put(bidValue, "bid from "+getCurrentOpAgentId().getAgentName()+ " for " + getId().toString());
    }
}