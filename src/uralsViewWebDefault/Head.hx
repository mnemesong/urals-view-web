package uralsViewWebDefault;

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

function renderHead<RenderOptions>(
    renderLink: (p: PublishedCss) -> String,
    bundle: PublishedAssetBundle
): String {
    return bundle.css.map(el -> renderLink(el)).join("\n");
}