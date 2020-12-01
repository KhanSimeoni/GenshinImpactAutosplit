state("GenshinImpact")
{
    int state : "UserAssembly.dll", 0xB6C668, 0xF0, 0x148, 0x118;
}

startup
{
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show(
            "This game uses Time without Loads (Game Time) as the main timing method.\n"
            + "LiveSplit is currently set to show Real Time (RTA).\n"
            + "Would you like to set the timing method to Game Time?",
            "Genshin Impact | LiveSplit",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }

    vars.setStartTime = false;
}

start
{
    if(current.state == 1 && old.state != 1)
    {
        print("test");
        vars.setStartTime = true;
        return true;
    }
}

isLoading
{
    return current.state != 1;
}

gameTime
{
    if(vars.setStartTime)
    {
        vars.setStartTime = false;
        return TimeSpan.FromSeconds(-34.10);
    }
}

exit
{
    timer.IsGameTimePaused = true;
}

