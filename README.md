# urals-view-web


## Description
Simple and effective tool for rendering view of web application.


## Requirements
Package tested for Haxe >= 4.0.
The functionality or it missing of the package for lesser versions has not been tested.


## Quick start
1. urals-view-web as library to your project
2. Add this code for generating web-page
```haxe
...
var csrfGenStubFunc = () -> "csrf_stub";
var page = UralsViewWeb.renderContent(
    "Some content", 
    UralsViewWeb.defaultTemplate,
    UralsViewWeb.defaultRenderOptions("en", "Main page", csrfGenStubFunc)
);
...
```
3. It will generate you default page.


## Using
Package consist of two modules:
- `UralsViewWeb` - basic tool, contains `UralsViewWeb.renderContent(...)` function for rendering page and needles types
- `UralsViewWebDefault` - default values keeper module for UralsViewWeb
- You may redefine any of its arguments for your needles in App, or use default values in UralsViewWebDefault


## UralsViewWeb API
```haxe
UralsViewWeb.renderContent<RenderOptions>(
    content: String, 
    template: PageTemplateFunction<RenderOptions>, 
    options: RenderOptions,
    ?bundle: PublishedAssetBundle
): String {...}
```


## UralsViewWebDefault API
```haxe
/**
    Default template function for UralsViewWeb
**/
function defaultTemplate(
    content: String,
    options: DefaultRenderOptions,
    ?bundle: PublishedAssetBundle
): String {...}

/**
    Default render options generator for UralsViewWeb
**/
function defaultRenderOptions( 
    lang: String, 
    title: String,
    csrfGenerator: () -> String
): DefaultRenderOptions {...}

/**
    Render style link teg by published css
**/
function styleLinkTag(
    p: PublishedCss
): String {...}

/**
    Render Script tag
**/
function scriptTag(
    s: PublishedScript
): String {...}
```

## Used types
```haxe
private typedef PublishedScript = {
    url: String,
    async: Bool,
    defer: Bool,
    ?language: String,
    type: String
}

private typedef PublishedCss = {
    url: String,
    ?media: String,
    ?type: String
}

private typedef PublishedAssetBundle = {
    scripts: Array<PublishedScript>,
    css: Array<PublishedCss>,
}

private typedef PageTemplateFunction<RenderOptions> = (
    content: String,
    options: RenderOptions,
    ?bundle: PublishedAssetBundle
) -> String;

private typedef DefaultRenderOptions = {
    lang: String,
    charset: String,
    csrfTokenName: String,
    csrfGenFunc: () -> String,
    title: String,
    renderHead: (bundle: PublishedAssetBundle) -> String,
    renderEndBody: (bundle: PublishedAssetBundle) -> String,
}
```


## Author
Anatoly Starodubtsev
Tostar74@mail.ru