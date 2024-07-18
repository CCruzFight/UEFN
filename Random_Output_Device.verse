
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Random}

random_output_device := class(creative_device):

    @editable
    Trigger_StartRNG : trigger_device = trigger_device{}

    @editable
    Triggers : []trigger_device = array{}

    var LastSelection : int = -1

    OnBegin<override>()<suspends>:void=
        Trigger_StartRNG.TriggeredEvent.Subscribe(RandomizeTrigger)

    RandomizeTrigger(InAgent: ?agent):void=
        ChosenTrigger := GetRandomInt(0, Triggers.Length-1)
        Print("Chosen Trigger is number {ChosenTrigger} and the previous selection was number {LastSelection}")
        if (ChosenTrigger = LastSelection):
            Print ("Rerolling mode...")
            RandomizeTrigger(InAgent)
        else:
            if (Trigger := Triggers[ChosenTrigger]):
                Trigger.Trigger()
                set LastSelection = ChosenTrigger
                Print("Set Last Selection to {LastSelection}")
