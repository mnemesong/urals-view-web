package viewWebDefault;

private typedef PublishedScriptInHead = {
    url: String,
    async: Bool,
    defer: Bool,
    ?language: String,
    type: String
}

private typedef PublishedCssInHead = {
    url: String,
    ?media: String,
    ?type: String
}

private typedef PublishedAssetBundleInHead = {
    scripts: Array<PublishedScriptInHead>,
    css: Array<PublishedCssInHead>,
}

private typedef MetaOption = {
    name: String,
    content: String
};

private typedef LinkOption = {
    rel: String,
    ?type: String,
    href: String,
    ?media: String
}

private typedef HeadOptions = {
    metas: Array<MetaOption>,
    links: Array<LinkOption>,
}

private function renderMeta(options: MetaOption): String 
{
    return '<meta name="${options.name}" content="${options.content}">';
}

private function renderLink(option: LinkOption): String {
    var typeBlock = (option.type != null) 
        ? ' type="${option.type}"'
        :  "";
    var mediaBlock = (option.media != null) 
        ? ' media="${option.media}"'
        : "";
    return '<link href="${option.href}" '
        + 'rel="${option.rel}"${typeBlock}${mediaBlock}>';
}

private function convertBundleToHeadOptions(
    bundle: PublishedAssetBundleInHead
): HeadOptions {
    function publishedCssToLinkOption(
        p: PublishedCssInHead
    ): LinkOption {
        return {
            rel: "stylesheet",
            type: ((p.type == null) || (p.type.length == 0))
                ? null
                : p.type,
            href: p.url,
            media: ((p.media == null) || (p.media.length == 0))
                ? null
                : p.media,
        }
    }
    return {
        metas: [],
        links: bundle.css.map(publishedCssToLinkOption),
    }
}

function renderHead<RenderOptions>(
    ?bundle: PublishedAssetBundleInHead
): String {
    var headOpts = (bundle == null)
        ? { metas: [], links: [] }
        : convertBundleToHeadOptions(bundle);
    var metaStrings = headOpts.metas.map(el -> renderMeta(el));
    var linkStrings = headOpts.links.map(el -> renderLink(el));
    return metaStrings.join("\n") + linkStrings.join("\n");
}