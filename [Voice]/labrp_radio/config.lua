Config = {}

Config.jobChannels = {
    -- Set custom channels for jobs here
    -- job: Name of the job
    -- min & max: Minimum and maximum restricted channel the job can join
    {job="police", min=1, max=4},
    {job="fbi", min=1, max=4},
    {job="ambulance", min=1, max=4},
    {job="trucker", min=42, max=42}
}

-- Set the default key to open the radio.
Config.DefaultOpenKey = ""