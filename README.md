# Colors utilities

Add the library to your project

```
dub add colors
```

## Color by name

```d
Nullable!Color color = Color.fromName("blue");
```

## Color by hex string

```d
Nullable!Color color = Color.fromHexString("#dddddd");
```

## Color by RGB

```d
//                         R    G  B
Nullable!Color color = Color.fromRGB(255, 0, 0);
//                         R    G  B  A
auto color = Color.fromRGB(255, 0, 0, 196);
```

## Color by HSL

TODO

## Color by HSB

TODO

## Color to HexString

```d
auto color = Color.fromName("blue");
writeln(color.get.hexString);
```

## Color to RGB

```d
Nullable!Color color = Color.fromName("blue");
writeln(color.get.rgb);
```

## Color to HSL
TODO

## Color to HSB
TODO

## Color to name

```d
auto color = Color.fromHexString("#000000");
writeln(color.get.name);
```

## RGBA methods

```d
auto color = Color.fromName("skyblue");
auto skyblue = color.get;
writefln("R: %d  G: %d  B: %d  A: %d", skyblue.r, skyblue.g, skyblue.b, skyblue.a);
```
### To get RGBA values between 0 - 1.0

```d
auto color = Color.fromName("skyblue");
auto skyblue = color.get;
writefln("R: %d  G: %d  B: %d  A: %d", skyblue.r100, skyblue.g100, skyblue.b100, skyblue.a100);
```
