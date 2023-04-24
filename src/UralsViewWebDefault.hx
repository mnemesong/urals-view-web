package;

import uralsViewWebDefault.EndBody.renderEndBody;
import uralsViewWebDefault.Head.renderHead;

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

private typedef DefaultRenderOptions = {
    lang: String,
    charset: String,
    csrfTokenName: String,
    csrfGenFunc: () -> String,
    title: String,
    renderHead: (bundle: PublishedAssetBundle) -> String,
    renderEndBody: (bundle: PublishedAssetBundle) -> String,
}

/**
    Default template function for UralsViewWeb
**/
function defaultTemplate(
    content: String,
    options: DefaultRenderOptions,
    ?bundle: PublishedAssetBundle
): String {
    var head = (bundle == null) ? "" : options.renderHead(bundle);
    var endBody = (bundle == null) ? "" : options.renderEndBody(bundle);
    return '
<html lang="${options.lang}" class="h-100">
    <head>
        <meta charset="${options.charset}">
        <meta name="viewport" 
              content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="csrf-param" content="${options.csrfTokenName}">
        <meta name="csrf-token" content="${options.csrfGenFunc()}">
        <title>${options.title}</title>
        ${head}
    </head>
    <body class="d-flex flex-column h-100">
        <main role="main" class="flex-shrink-0 mt-4" style="overflow: auto; top:43px;">
            ${content}
        </main>
        ${endBody}
    </body>
</html>';
}

/**
    Render style link teg by published css
**/
function styleLinkTag(p: PublishedCss): String {
    var option = {
        rel: "stylesheet",
        type: ((p.type == null) || (p.type.length == 0))
            ? null
            : p.type,
        href: p.url,
        media: ((p.media == null) || (p.media.length == 0))
            ? null
            : p.media,
    };
    var typeBlock = (option.type != null) 
        ? ' type="${option.type}"'
        :  "";
    var mediaBlock = (option.media != null) 
        ? ' media="${option.media}"'
        : "";
    return '<link href="${option.href}" '
        + 'rel="${option.rel}"${typeBlock}${mediaBlock}>';
}

/**
    Render Script tag
**/
function scriptTag(s: PublishedScript): String 
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

/**
    Default render options generator for UralsViewWeb
**/
function defaultRenderOptions(
    lang: String, 
    title: String,
    csrfGenerator: () -> String
): DefaultRenderOptions  {
    return {
        lang: lang,
        charset: "UTF-8",
        csrfTokenName: "_csrf",
        csrfGenFunc: csrfGenerator,
        title: title,
        renderHead: (bundle) -> renderHead(styleLinkTag, bundle),
        renderEndBody: (bundle) -> renderEndBody(scriptTag, bundle),
    }
}