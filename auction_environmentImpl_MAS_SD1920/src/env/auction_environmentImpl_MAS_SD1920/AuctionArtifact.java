// CArtAgO artifact code for project auction_environmentImpl_MAS_SD1920

package auction_environmentImpl_MAS_SD1920;

import jason.asSyntax.Atom;
import cartago.*;

public class AuctionArtifact extends Artifact {

    String currentWinner = "no_winner";

    public void init()  {
        // observable properties
        defineObsProperty("running",     "no");
        defineObsProperty("best_bid",    Double.MIN_VALUE);
        defineObsProperty("winner",      new Atom(currentWinner)); //Atom -- the most simple literal, is composed by only a functor (no term, no annots)
    }

    @OPERATION public void start(String task)  {
        if (getObsProperty("running").stringValue().equals("yes"))
            failed("The protocol is already running and so you cannot start it!");

        defineObsProperty("task", task);
        getObsProperty("running").updateValue("yes");
    }

    @OPERATION public void stop()  {
        if (! getObsProperty("running").stringValue().equals("yes"))
            failed("The protocol is not running, you cannot stop it!");

        getObsProperty("running").updateValue("no");
        getObsProperty("winner").updateValue(new Atom(currentWinner));
    }

    @OPERATION public void bid(double bidValue) {
        if (getObsProperty("running").stringValue().equals("no"))
            failed("You can not bid, auction not available. It is not running!");

        ObsProperty opCurrentValue  = getObsProperty("best_bid");
        if (bidValue > opCurrentValue.doubleValue()) {  // the bid is better than the previous
            opCurrentValue.updateValue(bidValue);
            currentWinner = getCurrentOpAgentId().getAgentName(); // the name of the agent doing this operation
        }
        System.out.println("Received bid "+bidValue+" from "+getCurrentOpAgentId().getAgentName()+" for "+getObsProperty("task").stringValue());
    }
}