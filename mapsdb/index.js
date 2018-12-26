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

function parsePudData(data) {
    var mapElement = document.createElement('map');
    var titleElement = document.createElement('title');
    var featuresElement = document.createElement('features');
    var gameElement = document.createElement('game');
    var authorElement = document.createElement('author');
    var releaseElement = document.createElement('release');

    gameElement.setAttribute('gameId', 'wc2');
    authorElement.setAttribute('authorId', 'authId:0');
    mapElement.appendChild(titleElement);
    mapElement.appendChild(featuresElement);
    mapElement.appendChild(gameElement);
    mapElement.appendChild(authorElement);
    mapElement.appendChild(releaseElement);

    parseChunkData(data, {
        // Reference: http://cade.datamax.bg/war2x/pudspec.html
        'VER': function (data) {
            var version = data.getUint16(0, true);

            if (version === 17) {
                gameElement.setAttribute('versionId', 'wc2:td');
                releaseElement.textContent = '1995-12-09';
            } else if (version === 19) {
                gameElement.setAttribute('versionId', 'wc2:bdp');
                releaseElement.textContent = '1996-04-30';
            }
        },
        'DESC': function (data) {
            var charCodes = new Uint8Array(data.buffer, data.byteOffset, data.byteLength);
            var description = String.fromCharCode.apply(null, charCodes).trim();
            var descriptionElement = document.createElement('desciption');

            descriptionElement.appendChild(document.createTextNode(description));
            titleElement.appendChild(descriptionElement);
        },
        'OWNR': function (data) {
            var ownerData = new Uint8Array(data.buffer, data.byteOffset, 8);
            var humans = 0;
            var computers = 0;

            for (var ownerIndex in ownerData) {
                if (ownerData[ownerIndex] === 4) {
                    computers += 1;
                } else if (ownerData[ownerIndex] === 5) {
                    humans += 1;
                }
            }

            featuresElement.setAttribute('minPlayers', computers > 0 ? 1 : 2);
            featuresElement.setAttribute('maxPlayers', humans);
        },
        'ERA': function (data) {
            var tileset = {
                0: 'Forest',
                1: 'Winter',
                2: 'Wasteland',
                3: 'Swamp',
            }[data.getUint16(0, true)];

            featuresElement.setAttribute('tileset', tileset);
        },
        'DIM': function (data) {
            var x = data.getUint16(0, true);
            var y = data.getUint16(2, true);
            var sizeElement = document.createElement('size');

            sizeElement.setAttribute('x', x);
            sizeElement.setAttribute('y', y);
            mapElement.appendChild(sizeElement);
        },
    });

    return mapElement;
}

function parseChunkData(arrayBuffer, chunkCallbacks) {
    var position = 0;
    var data = new DataView(arrayBuffer);

    while (position < data.byteLength) {
        var headerCharCodes = [
            data.getUint8(position + 0),
            data.getUint8(position + 1),
            data.getUint8(position + 2),
            data.getUint8(position + 3),
        ];
        var chunkHeader = String.fromCharCode.apply(null, headerCharCodes).trim();
        var chunkLength = data.getUint32(position + 4, true);

        if (chunkHeader in chunkCallbacks) {
            chunkCallbacks[chunkHeader](new DataView(arrayBuffer, position + 8, chunkLength));
        }

        position += chunkLength + 8;
    }
}

function displayResult() {
    loadXml("broodwar-map-of-the-week.xml").then(function (xml) {
        loadXml("db-to-html.xslt").then(function (xsl) {
            var transformedXml = transform(xsl, xml);
            $('body').append(transformedXml);
        });
    });

    loadPud('w2-maps/(4)Cliffhanger BNE.pud').then(parsePudData).then(console.log);
    loadPud('w2-maps/(4)Mountain Pass BNE.pud').then(parsePudData).then(console.log);
    loadPud('w2-maps/(6)Beetle Island BNE.pud').then(parsePudData).then(console.log);
}

function loadPud(filename) {
    return $.ajax({
        url: filename,
        dataType: 'native',
        xhrFields: {
            responseType: 'arraybuffer',
        },
    });
}

window.onload = displayResult;
