function text2xml(xmlString) {
    try {
        return text2msxml(xmlString);
    } catch (error) {
        return text2domxml(xmlString);
    }
}

function text2msxml(xmlString) {
    var msxml = new ActiveXObject('Microsoft.XMLDOM');
    msxml.async = 'false';
    msxml.loadXML(xmlString);
    return msxml;
}

function text2domxml(xmlString) {
    var parser = new DOMParser();
    return parser.parseFromString(xmlString, "text/xml");
}

function loadXml(filename) {
    return $
        .ajax({ url: filename, dataType: 'text' })
        .then(text2xml);
}

function transform(xsl, xml) {
    try {
        // code for IE
        return $(xml.transformNode(xsl));
    } catch (error) {
        // code for Chrome, Firefox, Opera, etc.
        var xsltProcessor = new XSLTProcessor();
        xsltProcessor.importStylesheet(xsl);
        return $(xsltProcessor.transformToFragment(xml, document));
    }
}

function displayResult() {
    loadXml("broodwar-map-of-the-week.xml").then(function (xml) {
        loadXml("db-to-html.xslt").then(function (xsl) {
            var transformedXml = transform(xsl, xml);
            $('body').append(transformedXml);
        });
    });
}

window.onload = displayResult;
