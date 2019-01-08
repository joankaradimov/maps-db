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
        var stringOutput = xml.transformNode(xsl);
        try {
            return $(stringOutput);
        } catch (error) {
            return $('<span>').text(stringOutput);
        }
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

    titleElement.appendChild(document.createElement('name'));
    gameElement.setAttributeNS(null, 'gameId', 'wc2');
    authorElement.setAttributeNS(null, 'authorId', 'auth-0');
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
                gameElement.setAttributeNS(null, 'versionId', 'wc2-td');
                releaseElement.textContent = '1995-12-09';
            } else if (version === 19) {
                gameElement.setAttributeNS(null, 'versionId', 'wc2-bdp');
                releaseElement.textContent = '1996-04-30';
            }
        },
        'DESC': function (data) {
            var charCodes = new Uint8Array(data.buffer, data.byteOffset, data.byteLength);
            var description = String.fromCharCode.apply(null, charCodes).replace(/[\0\s]*$/, '');
            var descriptionElement = document.createElement('description');

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

            featuresElement.setAttributeNS(null, 'minPlayers', computers > 0 ? 1 : 2);
            featuresElement.setAttributeNS(null, 'maxPlayers', humans);
        },
        'ERA': function (data) {
            var tileset = {
                0: 'Forest',
                1: 'Winter',
                2: 'Wasteland',
                3: 'Swamp',
            }[data.getUint16(0, true)];

            featuresElement.setAttributeNS(null, 'tileset', tileset);
        },
        'DIM': function (data) {
            var x = data.getUint16(0, true);
            var y = data.getUint16(2, true);
            var sizeElement = document.createElement('size');

            sizeElement.setAttributeNS(null, 'x', x);
            sizeElement.setAttributeNS(null, 'y', y);
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

function displayXml(xml, xslt) {
    loadXml(xml).then(function (xml) {
        loadXml(xslt).then(function (xsl) {
            var transformedXml = transform(xsl, xml);
            $('#content').html(transformedXml);
        });
    });
}

function displayPuds(xslt) {
    loadPuds([
        'warcraft2-maps-of-the-week/(4)Cliffhanger BNE.pud',
        'warcraft2-maps-of-the-week/(4)Mountain Pass BNE.pud',
        'warcraft2-maps-of-the-week/(6)Beetle Island BNE.pud',
    ]).then(function (xml) {
        loadXml(xslt).then(function (xsl) {
            var transformedXml = transform(xsl, xml);
            $('#content').html(transformedXml);
        });
    });
}

function createElementWithText(tagName, text) {
    var result = document.createElement(tagName);
    result.textContent = text;
    return result;
}

function createTitleElement(name, description, logo) {
    var result = document.createElement('title');

    if (name != null) {
        result.appendChild(createElementWithText('name', name));
    }
    if (description != null) {
        result.appendChild(createElementWithText('description', description));
    }
    if (logo != null) {
        result.appendChild(createElementWithText('logo', logo));
    }

    return result;
}

function createAuthorElement(id, name, logo, url) {
    var result = document.createElement('author');
    result.setAttribute('id', id);
    result.appendChild(createTitleElement(name, null, logo));
    result.appendChild(createElementWithText('url', url));
    return result;
}

function createGameElement(id, name, description, logo, versionElements) {
    var result = document.createElement('game');
    var versionsElement = document.createElement('versions')
    result.setAttribute('id', id);
    result.appendChild(createTitleElement(name, description, logo));
    result.appendChild(versionsElement);

    for (var i in versionElements) {
        versionsElement.appendChild(versionElements[i]);
    }

    return result;
}

function createVersionElement(id, name, description, logo, authorId, releaseDate) {
    var result = document.createElement('version');
    var authorElement = document.createElement('author');
    var releaseElement = document.createElement('release');

    authorElement.setAttributeNS(null, 'authorId', authorId);
    releaseElement.textContent = releaseDate;

    result.setAttributeNS(null, 'id', id);
    result.appendChild(createTitleElement(name, description, logo));
    result.appendChild(authorElement);
    result.appendChild(releaseElement);

    return result;
}

function loadPuds(filenames) {
    var result = $.Deferred();

    var mapdbElement = document.createElement('mapdb');
    var mapsElement = document.createElement('maps');
    var authorsElement = document.createElement('authors');
    var gamesElement = document.createElement('games');

    mapdbElement.appendChild(mapsElement);
    mapdbElement.appendChild(authorsElement);
    mapdbElement.appendChild(gamesElement);

    authorsElement.appendChild(createAuthorElement('auth-0', 'Blizzard', 'authors/blizzard-logo.png', 'www.blizzard.com'));
    authorsElement.appendChild(createAuthorElement('auth-1', 'Cyberlore Studios', 'authors/cyberlore-studios.png', 'http://www.cyberlore.com/'));

    gamesElement.appendChild(createGameElement('wc2', 'Warcraft 2', null, 'games/warcraft2.png', [
        createVersionElement('wc2-td', 'Warcraft 2: Tides of Darkness', null, 'games/warcraft2.png', 'auth-0', '1995-12-09'),
        createVersionElement('wc2-bdp', 'Warcraft 2: Beyond the Dark Portal', null, 'games/warcraft2-exp.png', 'auth-1', '1996-04-30'),
    ]));

    for (var i in filenames) {
        loadPud(filenames[i]).then(loaded).catch(result.reject);
    }

    function loaded(mapElement) {
        mapsElement.appendChild(mapElement);
        if (mapsElement.childElementCount === filenames.length) {
            result.resolve(text2xml(mapdbElement.outerHTML));
        }
    }

    return result;
}

function loadPud(filename) {
    return $
        .ajax({
            url: filename,
            dataType: 'native',
            xhrFields: {
                responseType: 'arraybuffer',
            },
        })
        .then(parsePudData)
        .then(function (xml) {
            xml.querySelector('title name').textContent = filename.replace(/^.*\(\d+\)/, '').replace(/\.pud$/, '');
            xml.appendChild(document.createElement('downloads'));
            xml.querySelector('downloads').appendChild(document.createElement('full'));
            xml.querySelector('downloads full').textContent = filename;
            return xml;
        });
}
