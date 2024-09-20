module colors;

import std.typecons;
import std.conv;
import std.string;

import colors.names;

enum ColorMode
{
    RGB,
    HSL,
    HSB
}

struct Color
{
    int v1;
    int v2;
    int v3;
    int v4 = -1;
    ColorMode mode = ColorMode.RGB;

    int alphaDefault()
    {
        if (mode == ColorMode.RGB)
            return 255;

        // TODO: Return default for other modes
        return 255;
    }

    static Nullable!Color fromName(string name)
    {
        Nullable!Color color;
        auto value = name in colorNames;
        if (value !is null)
        {
            auto rgb = *value;
            color = Color.fromRGB(rgb[0], rgb[1], rgb[2]);
        }
        return color;
    }

    static Nullable!Color fromHex(string name)
    {
        auto h = name.strip("#");
        Color color;
        color.v1 = h[0 .. 2].to!int(16);
        color.v2 = h[2 .. 4].to!int(16);
        color.v3 = h[4 .. 6].to!int(16);

        color.v4 = h.length == 8 ? h[6 .. 8].to!int(16) : 255;
        color.mode = ColorMode.RGB; 
        return color.nullable;
    }

    static Nullable!Color fromRGB(int r, int g, int b, int a = 255)
    {
        if (r < 0 || g < 0 || b < 0 || a < 0 || r > 255 || g > 255 || b > 255 || a > 255)
            return Nullable!Color.init;

        return Color(r, g, b, a, ColorMode.RGB).nullable;
    }

    static Nullable!Color fromHSL(int r, int g, int b, int a = 255)
    {
        return Color(r, g, b, a, ColorMode.HSL).nullable;
    }
    
    static Nullable!Color fromHSB(int r, int g, int b, int a = 255)
    {
        return Color(r, g, b, a, ColorMode.HSB).nullable;
    }

    int r()
    {
        if (mode == ColorMode.RGB)
            return v1;

        // TODO: Convert if other format
        return 0;
    }

    double r100()
    {
        return r / 255.0;
    }

    int g()
    {
        if (mode == ColorMode.RGB)
            return v2;

        // TODO: Convert if other format
        return 0;
    }

    double g100()
    {
        return g / 255.0;
    } 

    int b()
    {
        if (mode == ColorMode.RGB)
            return v3;

        // TODO: Convert if other format
        return 0;
    }

    double b100()
    {
        return b / 255.0;
    }

    int a()
    {
        if (mode == ColorMode.RGB)
            return v4 == -1 ? alphaDefault : v4;

        // TODO: For all modes and default values if -1
        return 0;
    }

    double a100()
    {
        return a / 255.0;
    }

    Color rgb()
    {
        if (mode == ColorMode.RGB)
            return this;

        // TODO: Convert from HSB and HSL
        //if (mode == ColorMode.HSB)
        
        return Color.init;
    }

    string hex()
    {
        auto rgbColor = this.rgb;
        return "#" ~ r.to!string(16) ~ g.to!string(16) ~ b.to!string(16) ~ a.to!string(16);
    }

    private RGB toRGBTuple()
    {
        return RGB(r, g, b);
    }

    string name()
    {
        auto rgbColor = this.toRGBTuple;
        foreach (color; colorNames.byKeyValue)
        {
            if (color.value == rgbColor)
                return color.key;
        }

        // Name not found, return the hex name
        return this.hex;
    }
}

unittest
{
    auto color = Color.fromName("red");
    assert(!color.isNull);
    assert(color.get.r == 255);
    assert(color.get.g == 0);
    assert(color.get.b == 0);
    assert(color.get.a == 255);

    auto color2 = Color.fromHex("#dddddd");
    assert(!color2.isNull);
    assert(color2.get.r == 221);
    assert(color2.get.g == 221);
    assert(color2.get.b == 221);
    assert(color2.get.a == 255);

    assert(Color.fromRGB(221, 221, 221).get.hex == "#DDDDDDFF");
}
