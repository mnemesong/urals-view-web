package viewWebDefault;

private typedef PublishedScriptInEndBody = {
    url: String,
    async: Bool,
    defer: Bool,
    ?language: String,
    type: String
}

private typedef PublishedCssInEndBody = {
    url: String,
    ?media: String,
    ?type: String
}

private typedef PublishedAssetBundleInEndBody = {
    scripts: Array<PublishedScriptInEndBody>,
    css: Array<PublishedCssInEndBody>,
}

private function renderScriptTag(s: PublishedScriptInEndBody): String 
{
    var deferBlock = (s.defer == true) 
        ? ' defer' 
        : '';
    var languageBlock = (s.language == null)
        ? ''
        : ' language="${s.language}"';
    var asyncBlock = (s.async == true)
        ? ' async'
        : '';
    return '<script type="${s.type}" src="${s.url}"' 
        + '${deferBlock}${languageBlock}${asyncBlock}></script>';
}

function renderEndBody<RenderOptions>(
    ?bundle: PublishedAssetBundleInEndBody
): String {
    return (bundle == null)
        ? ""
        : bundle.scripts.map(renderScriptTag).join("\n");
}