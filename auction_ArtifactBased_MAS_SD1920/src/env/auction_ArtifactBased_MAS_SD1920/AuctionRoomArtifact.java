// CArtAgO artifact code for project auction_ArtifactBased_MAS_SD1920

package auction_ArtifactBased_MAS_SD1920;

import java.util.ArrayList;
import java.util.List;

import cartago.*;
import jason.asSyntax.Atom;

public class AuctionRoomArtifact extends Artifact {
	
	List<String> subbed = new ArrayList<String>();
	String currentWinner = "no_winner";
	String errorMsg = "no_errors";
	
	void init() {
		subbed = SubscriptionArtifact.getSubList();
		defineObsProperty("running",     "no");
        defineObsProperty("best_bid",    0.0);
        defineObsProperty("winner",      new Atom(currentWinner));
	}

	@OPERATION
	void start(String task) {
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
    }
    
    @OPERATION public void bid(double bidValue) {
    	/*error check*/
    	if (getObsProperty("running").stringValue().equals("no")) {
            failed("You can not bid, auction not available. It is not running!");
    		errorMsg = "bid_intention";
    	}
    	if( ! bidCheck(getCurrentOpAgentId().getAgentName())) {
    		failed("You can not bid, you are not subbed to this auction!");
    		errorMsg = "participant_not_existing";
    	}
    	//check error passed
        ObsProperty opCurrentValue  = getObsProperty("best_bid");
        if (bidValue > opCurrentValue.doubleValue()) {  // the bid is better than the previous
            opCurrentValue.updateValue(bidValue);
            currentWinner = getCurrentOpAgentId().getAgentName(); // the name of the agent doing this operation
            System.out.println( "[" + getCurrentOpAgentId().getAgentName() + "]" + "relaunched with " + bidValue + 
            		" and now is winning the auction " + getId().toString() + "!!!");
        }
        System.out.println("Received bid "+bidValue+" from "+getCurrentOpAgentId().getAgentName()+" for "+getObsProperty("task").stringValue());
        ScoreBoardArtifact.addBidToScoreboard(bidValue, getCurrentOpAgentId().getAgentName(), getId().toString());
    }
    
    private boolean bidCheck(String agent) {
    	return subbed.contains(agent);
    }
}

