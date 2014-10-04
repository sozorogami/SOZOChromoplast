### Description

Inspired by functionality in iTunes' album view, `SOZOChromoplast` finds the most relevant colors in a given `UIImage` quickly and painlessly, giving you the perfect color scheme every time.

![analbumcover.gif](https://bitbucket.org/repo/KGj9zy/images/1874912793-analbumcover.gif)

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