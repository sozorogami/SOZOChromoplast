### Description

Inspired by functionality in iTunes' album view, `SOZOChromoplast` finds the most relevant colors in a given `UIImage` quickly and painlessly, giving you the perfect color scheme every time.

![analbumcover](https://cloud.githubusercontent.com/assets/1407680/5003713/8e430538-6a55-11e4-8f68-f5432cd5d1b3.gif)

### Usage

```obj-c
// Get an image
UIImage *someImage = [UIImage imageNamed:@"someImage.png"];

// Instantiate your chromoplast
SOZOChromoplast *chromoplast = [[SOZOChromoplast alloc] initWithImage:someImage];

// Use your colors!
self.view.backgroundColor = chromoplast.primaryColor;
self.label1.textColor = chromoplast.highlight1;
self.label2.textColor = chromoplast.highlight2;
```
