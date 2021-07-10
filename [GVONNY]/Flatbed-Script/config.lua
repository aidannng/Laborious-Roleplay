config = {
    flatbed_name = {
        "f550rb",
        "f550rbc",
        "16ramrb",
        "16ramrbc",
        "20ramrb",
        "20ramrbc"
    }, -- If you changed the name from f550rb to something else, change that here!
    controlText = "~INPUT_FRONTEND_LEFT~ raise bed ~r~ | ~w~ ~INPUT_FRONTEND_RIGHT~ lower bed", -- This text displays next to the "control" panel near the back left of the bed.
    controlText2 = "~INPUT_FRONTEND_LEFT~ raise bed ~r~ | ~w~ ~INPUT_FRONTEND_RIGHT~ lower bed", -- This text displays next to the "control" panel near the back left of the bed.
    carAttachLabel = "Press ~INPUT_FRONTEND_RRIGHT~ to attach entity.", -- ~INPUT_DETONATE~ is the G button. 
    carDetachLabel = "Press ~INPUT_FRONTEND_RRIGHT~ to detach entity.", -- ~INPUT_DETONATE~ is the G button. 
    SlidingSpeed = 1, -- Higher the Number, the slower the slider is. (note: if you want it slower, it will studder a bit.)
    FloatingText = false, -- Do you want 3d text near the controls, or a label?
    labelText = "~INPUT_FRONTEND_LEFT~ raise bed ~r~ | ~w~ ~INPUT_FRONTEND_RIGHT~ lower bed", -- This text displays on a label. (only if FloatingText is true)
    labelText2 = "~INPUT_FRONTEND_LEFT~ raise bed ~r~ | ~w~ ~INPUT_FRONTEND_RIGHT~ lower bed" -- This text displays on a label. (only if FloatingText is true)
}