// CArtAgO artifact code for project auction_ArtifactBased_MAS_SD1920

package auction_ArtifactBased_MAS_SD1920;

import java.util.ArrayList;
import java.util.List;

import cartago.*;

public class SubscriptionArtifact extends Artifact {
	
	static List<String> subbed;
	
	void init() {
		System.out.println("Subscription Artifact talking...");
		defineObsProperty("openSubscriptions", "yes");
	}
	
	@OPERATION public void start(String task)  {
		subbed = new ArrayList<String>();
	}
	
	@OPERATION public void stop()  {
		defineObsProperty("openSubscriptions", "no");
		System.out.println("No more subscriptions, max number of participant reached!!");
		System.out.println(subbed);
	}
	
	@OPERATION
	void sub() {
		if(getObsProperty("openSubscriptions").stringValue().equals("yes") 
				&& subbed.size() < 4 && (!subbed.contains(getCurrentOpAgentId().getAgentName()))) {
			subbed.add(getCurrentOpAgentId().getAgentName());
		}
	}
	
	
	static public List<String> getSubList() {
		return subbed;
	}
	
}

