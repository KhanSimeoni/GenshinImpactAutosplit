state("GenshinImpact")
{
    int gameStart : "UserAssembly.dll", 0x06B6C668, 0xF0, 0x148, 0x88; 
    int loadBit : "UserAssembly.dll", 0x06B6C668, 0xF0, 0x148, 0x118;
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
    vars.loading = true;
}

start
{
    if(current.gameStart == old.gameStart+1 && !vars.loading) //End of first loading screen
    {
        vars.setStartTime = true;
        return true;
    }
}

update
{
    if (current.loadBit == old.loadBit + 1) //Start of load
    {
        vars.loading = true;
    }
    if (current.loadBit == old.loadBit - 1) //End of load
    {
        vars.loading = false;
    }
    return true;
}

isLoading
{
    return vars.loading;
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
