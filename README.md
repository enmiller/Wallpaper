Wallpaper.swift
=========

Building something? Building something and need content? Building something and need some fast content that will make your designer work _much_ faster?? Put up some Wallpaper! Quick placeholder images, text, and colors for your apps.

Prefer the native Objective-C version? We've got you covered with [PlaceKit](http://github.com/larsacus/PlaceKit).

##Content
###Placeholders

_ProTip: Brisket and bacon wallpaper appear to have the greatest effect on that special visual designer in your life._

  - Random images from [placekitten.com](http://placekitten.com)
  - Random images from [baconmockup.com](http://baconmockup.com)
  - Random images from [lorempixel.net](http://lorempixel.com)
  - Generic dimensioned placeholders from [placehold.it](http://placehold.it)
  - Gorgeous Robert Downey Jr. headshots from [http://rdjpg.com](http://rdjpg.com)

###Text
  - Hipster based text from [hipsteripsum.me](http://hipsteripsum.me)
  - Lorem Ipsum text/HTML/HTML URLs from [loripsum.net](http://loripsum.net)

###Colors

Sometimes you don't care or don't want to think about the color of something. Sometimes you just want to differentiate different views. Create new colors to give you bland UI some dimension, give new views a random color to tell them apart or generate a new random color matching the hue of another:

- Random UIColor
- Random UIColor with specific hue
- Random UIColor with same hue as another UIColor
- Random greyscale color
- More

## Usage

### Images

```` swift
Wallpaper.placeKittenImage(imageView.size) { image in
  imageView.image = image
}
````

### Colors

```` swift
let initialColor = Wallpaper.placeRandomColor()
view1.backgroundColor = initialColor
view2.backgroundColor = Wallpaper.placeRandomColorWithHueOfColor(initialColor)
````

### Text

```` swift
Wallpaper.placeHipsterIpsum(numberOfParagraphs: 3, shotOfLatin: true) { hipsterText in
  textView.text = hipsterText
}
````

##Installation
The Wallpaper core was built dependency-free to make it as easy as possible to drop into your project. Simply drop `Wallpaper.swift` and away you go!

##Known Issues

1. Seriously? It's swift -- it's perfect.

##License
Standard MIT license
