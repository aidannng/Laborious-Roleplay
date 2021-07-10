Shells = {
    { -- This is tier1 motel room, which is the default one. You can upgrade to other rooms, but this is the base model.
        Id = 1,
        Object = "playerhouse_hotel",
        Offsets = {
            Storage = vector3(-0.87, 1.2, 1.0),
            Wardrobe = vector3(-0.6, 3.1, 1.0),
            Changechar = vector3(1.0, -0.15, 1.0),
            Door = vector3(-0.88674545288086, -3.5486145019531, 0.010009765625),
        },
        DefaultFurniture = {
            {
                object = "V_49_MotelMP_Curtains",
                offset = vector3(1.55156, -3.831001, 2.34575)
            },
            {
                object = "V_49_MotelMP_Curtains",
                offset = vector3(1.4319, -3.923151, 2.293296)
            },
            {
                object = "v_49_motelmp_stuff",
                offset = vector3(0.7, 0.35, 1.35)
            },
            {
                object = "v_49_motelmp_mirror",
                offset = vector3(0.7, 0.245, 1.815)
            },
            {
                object = "v_49_motelmp_bed",
                offset = vector4(2.0, -0.2, 1.4, 0.0)
            },
            {
                object = "v_49_motelmp_clothes",
                offset = vector3(-1.35, 2.3, 1.5)
            },
            {
                object = "prop_tv_cabinet_03",
                offset = vector4(-1.6, -0.2, 1.35, 90.0)
            },
            {
                object = "prop_tv_06",
                offset = vector4(-1.6, -0.2, 2.065, 90.0)
            },
        },
    },
    {
        Id = 2,
        Object = "modernhotel_shell", -- requires: https://k4mb1.store/collections/shells/products/modern-hotels-shells-pack
        Offsets = {
            Door = vector3(4.9934, 4.3496, -1.8079),
            Wardrobe = vector3(2.97, -3.595, -0.81),
            Storage = vector3(-4.2674, 3.5952, -0.8078),
            Changechar = vector3(-4.2674, 3.5952, -0.8078)
        },
        DefaultFurniture = {},
    },
    {
        Id = 3,
        Object = "standardmotel_shell", -- requires k4mb1's furnished motel shells
        Offsets = {
            Door = vector3(-0.241425, -2.456665, -1.546509),
            Wardrobe = vector3(1.354523, 2.453247, -0.546280),
            Storage = vector3(1.466095, -2.722137, -0.547974),
            Changechar = vector3(-4.2674, 3.5952, -0.8078)
        },
        DefaultFurniture = {},
    },
    {
        Id = 4,
        Object = "classicmotel_shell", -- requires k4mb1's furnished motel shells
        Offsets = {
            Door = vector3(0.074280, -3.478058, -1.327545),
            Wardrobe = vector3(2.662140, 3.253174, -0.327515),
            Storage = vector3(-4.198730, 2.148651, -0.327332),
            Changechar = vector3(-4.2674, 3.5952, -0.8078)
        },
        DefaultFurniture = {},
    },
    {
        Id = 5,
        Object = "highendmotel_shell", -- requires k4mb1's furnished motel shells
        Offsets = {
            Door = vector3(3.255310, 3.136688, -1.511353),
            Wardrobe = vector3(-0.448303, 0.673981, -0.511139),
            Storage = vector3(3.921356, -1.118256, -0.511078),
            Changechar = vector3(-4.2674, 3.5952, -0.8078),
        },
        DefaultFurniture = {},
    },
}