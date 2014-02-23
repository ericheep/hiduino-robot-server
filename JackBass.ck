// ===================================================================
//  File: JackBass.ck
//  Defines JackBox's bass OSC address etc. 
//  by Ness Morris and Bruce Lott 
//  based on code by Ajay Kapur, Owen Vallis & Dimitri Diakopoulos
//  CalArts Music Technology: Interaction, Intelligence & Design
//  2013-2014
// ===================================================================
public class JackBass extends Bot{
    int BassNotes[0];
    fun void init(OscRecv orec,OscSend toClient[]){
        _init(orec,"/jackbass","ii",toClient);
        midiInit("KarmetiK_JackBox Port A");
        data.size(2);
        for(28=>int i; i<52; i++) BassNotes<<i;
        BassNotes.cap()=>numAct;
    }
    
    fun void triggerLoop(){  // overriding Bot base definition
        while(trigger=>now){
            while(trigger.nextMsg()){
                trigger.getInt()=>data[0];
                trigger.getInt()=>data[1];
                if(data[1]>127)127=>data[1];
                if(data[1]<0)0=>data[1];
                if(data[0]>=0&data[0]<numAct){
                    if(data[1]>0){
                        midiSend(145,BassNotes[data[0]],data[1]);
                    }
                    else{
                        midiSend(129,BassNotes[data[0]],127);
                    }
                    echoOsc(data[0],data[1]);
                }
            }
        }
    }
    
}