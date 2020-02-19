// CArtAgO artifact code for project auction_ArtifactBased_MAS_SD1920

package auction_ArtifactBased_MAS_SD1920;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import cartago.*;

public class ScoreBoardArtifact extends Artifact {
	static HashMap<Double, String> auctionInfo;
	
	void init() {
		System.out.println("Scoreboard Artifact talking...");
		auctionInfo = new HashMap<Double, String>();
		auctionInfo.put(0.0, "iniziated auction for " + getId().toString());
	}

	@OPERATION
	void getScoreboard() {
		List<Double> sortedKeys=new ArrayList<Double>(auctionInfo.keySet());
        Collections.sort(sortedKeys);
    	for(int i = 0; i<sortedKeys.size(); i++) {
    		System.out.println(sortedKeys.get(i) + " " + auctionInfo.get(sortedKeys.get(i)).toString());
    	}
	}
	
	static void addBidToScoreboard(Double bid, String s, String id) {
		auctionInfo.put(bid, "bid from "+ s + " for " + id);
	}
}
