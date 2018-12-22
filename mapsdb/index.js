function loadXml(filename) {
    var xhttp = window.ActiveXObject ? new ActiveXObject("Msxml2.XMLHTTP") : new XMLHttpRequest();

    xhttp.open("GET", filename, false);
    try {
        xhttp.responseType = "msxml-document";
    } catch (err) {
        // Helping IE11
    }

    xhttp.send("");
    return xhttp.responseXML;
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
    var xml = loadXml("broodwar-map-of-the-week.xml");
    var xsl = loadXml("db-to-html.xslt");

    var transformedXml = transform(xsl, xml);
    $('#example').append(transformedXml);
}

window.onload = displayResult;
