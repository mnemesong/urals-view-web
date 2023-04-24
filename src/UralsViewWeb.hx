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

private typedef RenderFunction<RenderOptions> = (
    content: String, 
    options: RenderOptions,
    ?bundle: PublishedAssetBundle
) -> String;

private typedef RenderConfig<RenderOptions> = {
    renderHead: RenderFunction<RenderOptions>,
    renderBeginBody: RenderFunction<RenderOptions>,
    renderEndBody: RenderFunction<RenderOptions>,
    template: PageTemplateFunction<RenderOptions>
}

function renderContent<RenderOptions>(
    content: String, 
    template: PageTemplateFunction<RenderOptions>, 
    options: RenderOptions,
    ?bundle: PublishedAssetBundle
): String {
    return template(content, options, bundle);
}