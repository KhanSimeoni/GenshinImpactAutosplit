state("GenshinImpact")
{
    bool loading : "UserAssembly.dll", 0x0613CDC0, 0x358, 0x70, 0x2B8;
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
}

isLoading
{
    return current.loading;
}
exit
{
    timer.IsGameTimePaused = true;
}