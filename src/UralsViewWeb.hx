package;

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

/**
    Main function, calls page rendering
**/
function renderContent<RenderOptions>(
    content: String, 
    template: PageTemplateFunction<RenderOptions>, 
    options: RenderOptions,
    ?bundle: PublishedAssetBundle
): String {
    return template(content, options, bundle);
}