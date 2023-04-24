package;

import viewWebDefault.UralsEndBody.renderEndBody;
import viewWebDefault.UralsHead.renderHead;

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
        renderHead: renderHead,
        renderEndBody: renderEndBody,
    }
}