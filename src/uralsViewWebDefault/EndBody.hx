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

function renderEndBody<RenderOptions>(
    renderScriptTag: (s: PublishedScript) -> String,
    ?bundle: PublishedAssetBundle
): String {
    return (bundle == null)
        ? ""
        : bundle.scripts.map(renderScriptTag).join("\n");
}