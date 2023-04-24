package;

import sneaker.assertion.Asserter.*;

using StringTools;

private function testRenderContentWithoutBundle(): Void {
    var defaultOptions = {
        lang: "en",
        charset: "UTF-8",
        csrfTokenName: "_csrf",
        csrfGenFunc: () -> "AASFEF12312",
        title: "Main page",
        renderEndBody: (?bundle) -> "",
        renderHead: (?bundle) -> ""
    };
    var rendered = UralsViewWeb.renderContent(
        "Hello!",
        UralsViewWebDefault.defaultTemplate,
        defaultOptions
    );
    var nominal = '
<html lang="en" class="h-100">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" 
              content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="csrf-param" content="_csrf">
        <meta name="csrf-token" content="AASFEF12312">
        <title>Main page</title>

    </head>
    <body class="d-flex flex-column h-100">
        <main role="main" class="flex-shrink-0 mt-4" style="overflow: auto; top:43px;">
            Hello!
        </main>
        
    </body>
</html>';
    assert(rendered.replace(" ", "") == nominal.replace(" ", ""));
}

private function testRenderContentWithBundleAndDefaultConfig() {
    var bundle = {
        scripts: [{
            url: "/scripts/js.js",
            async: false,
            defer: true,
            type: "text/javascript"
        }],
        css: [{
            url: "/css/css.css",
            media: null,
            type: null
        }],
    };
    var csrfGenerator = () -> "AASFEF12312";
    var rendered = UralsViewWeb.renderContent(
        "Some Content",
        UralsViewWebDefault.defaultTemplate,
        UralsViewWebDefault.defaultRenderOptions("en", "Main page", csrfGenerator),
        bundle
    );
    var nominal = '
<html lang="en" class="h-100">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" 
              content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="csrf-param" content="_csrf">
        <meta name="csrf-token" content="AASFEF12312">
        <title>Main page</title>
        <link href="/css/css.css" rel="stylesheet">
    </head>
    <body class="d-flex flex-column h-100">
        <main role="main" class="flex-shrink-0 mt-4" style="overflow: auto; top:43px;">
            SomeContent
        </main>
        <script type="text/javascript" src="/scripts/js.js" defer></script>
    </body>
</html>';
    assert(rendered.replace(" ", "") == nominal.replace(" ", ""));
}

function main() {
    testRenderContentWithoutBundle();
    testRenderContentWithBundleAndDefaultConfig();
}