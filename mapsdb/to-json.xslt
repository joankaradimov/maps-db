<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" omit-xml-declaration="yes" indent="yes" />

  <xsl:template match="mapdb">
{
    "maps": [
      <xsl:apply-templates select="maps" />
    ],
    "authors": [
      <xsl:apply-templates select="authors" />
    ],
    "games": [
      <xsl:apply-templates select="games" />
    ]
}
  </xsl:template>

  <xsl:template match="maps">
    <xsl:apply-templates select="map" />
  </xsl:template>

  <xsl:template match="authors">
    <xsl:apply-templates select="author" />
  </xsl:template>

  <xsl:template match="games">
    <xsl:apply-templates select="game" />
  </xsl:template>
  
  <xsl:template match="title">
{
  "name": "<xsl:value-of select="title" />",
  "description": "<xsl:value-of select="description" />",
  "logo": "<xsl:value-of select="logo" />",
}
  </xsl:template>
  
  <xsl:template match="map">
{
  "title": <xsl:apply-templates select="title" />,
  "size": {
    "x": <xsl:value-of select="size/@x"/>,
    "y": <xsl:value-of select="size/@y"/>,
  },
  "preview": "<xsl:value-of select="preview" />",
  "game": {
    "gameId": "<xsl:value-of select="game/@gameId" />",
    "versionId": "<xsl:value-of select="game/@versionId" />",
  },
  "features": {
    "tileset": "<xsl:value-of select="features/@tileset" />",
    "minPlayers": <xsl:value-of select="features/@minPlayers" />,
    "maxPlayers": <xsl:value-of select="features/@maxPlayers" />,
    "teams": <xsl:value-of select="features/@teams" />,
    "island": <xsl:value-of select="features/@island" />,
    "useMapSettings": <xsl:value-of select="features/@useMapSettings" />,
    "ladder": <xsl:value-of select="features/@ladder" />
  },
  <!-- TODO: author, downloads -->
  "release": "<xsl:value-of select="release" />",
},
  </xsl:template>

  <xsl:template match="author">
{
  id: "<xsl:value-of select="@id" />",
  title: <xsl:apply-templates select="title" />,
  url: "<xsl:value-of select="url" />",
  email: "<xsl:value-of select="email" />",
},
  </xsl:template>

  <xsl:template match="game">
{
  "id": "<xsl:value-of select="@id" />",
  "title": <xsl:apply-templates select="title" />,
  "url": "<xsl:value-of select="url" />",
  "versions": [
    <xsl:apply-templates select="version" />,
  ]
},
  </xsl:template>

  <xsl:template match="version">
{
  "id": "<xsl:value-of select="@id" />",
  "title": <xsl:apply-templates select="title" />,
  <!-- TODO: author, downloads -->
},
  </xsl:template>
</xsl:stylesheet>
