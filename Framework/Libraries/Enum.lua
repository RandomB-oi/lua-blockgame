local CategoryMeta = {}

local function NewEnumCategory(categoryName, options)
    for name, enum in pairs(options) do
        enum.Name = name
        enum.EnumType = categoryName
    end

    return setmetatable(options, CategoryMeta)
end

local EntryMeta = {}
EntryMeta.__eq = function(self, other)
    return rawequal(self, other) or self.Name == other or self.Value == other
end

local function NewEntry(value)
    return setmetatable({
        Value = value,
        Name = nil,
        EnumType = nil,
    }, EntryMeta)
end
return {
    CollisionLayer = NewEnumCategory("ContextActionResult", {
        Default = NewEntry(0),
        Layer1 = NewEntry(1),
        Layer2 = NewEntry(2),
        Layer3 = NewEntry(3),
        Layer4 = NewEntry(4),
        Layer5 = NewEntry(5),
        Layer6 = NewEntry(6),
        Layer7 = NewEntry(7),
    }),

    ContextActionResult = NewEnumCategory("ContextActionResult", {
        Sink = NewEntry(1),
        Pass = NewEntry(2),
    }),

    UserInputType = NewEnumCategory("UserInputType", {
        Unknown = NewEntry(0),
        MouseButton1 = NewEntry(1),
        MouseButton2 = NewEntry(2),
        MouseButton3 = NewEntry(3),
        MouseButton4 = NewEntry(4),
        MouseButton5 = NewEntry(5),
        Keyboard = NewEntry(6),
    }),

    UserInputState = NewEnumCategory("UserInputState", {
        Began = NewEntry(1),
        Ended = NewEntry(2),
        Changed = NewEntry(3),
    }),

    KeyCode = NewEnumCategory("KeyCode", {
        Zero = NewEntry("0"),
        One = NewEntry("1"),
        Two = NewEntry("2"),
        Three = NewEntry("3"),
        Four = NewEntry("4"),
        Five = NewEntry("5"),
        Six = NewEntry("6"),
        Seven = NewEntry("7"),
        Eight = NewEntry("8"),
        Nine = NewEntry("9"),

        A = NewEntry("a"),
        B = NewEntry("b"),
        C = NewEntry("c"),
        D = NewEntry("d"),
        E = NewEntry("e"),
        F = NewEntry("f"),
        G = NewEntry("g"),
        H = NewEntry("h"),
        I = NewEntry("i"),
        J = NewEntry("j"),
        K = NewEntry("k"),
        L = NewEntry("l"),
        M = NewEntry("m"),
        N = NewEntry("n"),
        O = NewEntry("o"),
        P = NewEntry("p"),
        Q = NewEntry("q"),
        R = NewEntry("r"),
        S = NewEntry("s"),
        T = NewEntry("t"),
        U = NewEntry("u"),
        V = NewEntry("v"),
        W = NewEntry("w"),
        X = NewEntry("x"),
        Y = NewEntry("y"),
        Z = NewEntry("z"),

        Space = NewEntry("space"),

        Unknown = NewEntry("unknown"),
    }),
}